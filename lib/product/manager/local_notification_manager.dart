import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../core/manager/local_notification/base_local_notification_manager.dart';
import '../model/local_notification_model.dart';

class LocalNotificationManager implements BaseLocalNotificationManager<LocalNotificationModel> {
  static final LocalNotificationManager _instace = LocalNotificationManager._init();
  static LocalNotificationManager get instance => _instace;

  LocalNotificationManager._init() {
    _localNotificationPlugin = FlutterLocalNotificationsPlugin();
    onNotifications = BehaviorSubject<String?>();
  }

  late final FlutterLocalNotificationsPlugin _localNotificationPlugin;
  late final BehaviorSubject onNotifications;

  @override
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = IOSInitializationSettings(
      requestBadgePermission: true,
      requestAlertPermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotificationPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        onNotifications.add(payload);
      },
    );

    // gets the local time zone for scheduled notifications
    final location = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(location));
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId",
        "channelName",
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  @override
  Future<void> showNotification(LocalNotificationModel model) async {
    await _localNotificationPlugin.show(
      model.id,
      model.title,
      model.body,
      _notificationDetails(),
      payload: model.payload,
    );
  }

  @override
  Future<void> showScheduledNotification(LocalNotificationModel model) async {
    await _localNotificationPlugin.zonedSchedule(
      model.id,
      model.title,
      model.body,
      tz.TZDateTime.from(model.dateTime!, tz.local),
      _notificationDetails(),
      payload: model.payload,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _localNotificationPlugin.cancelAll();
  }

  @override
  Future<void> cancelNotificationById(int id) async {
    await _localNotificationPlugin.cancel(id);
  }
}
