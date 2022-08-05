import '../manager/local_notification_manager.dart';

class LocalNotificationsInit {
  Future<void> initializeLocalNotifications() async {
    await LocalNotificationManager.instance.initialize();
  }
}
