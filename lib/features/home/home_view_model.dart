import 'dart:math';

import 'package:flutter/material.dart';

import '../../product/manager/local_notification_manager.dart';
import '../../product/model/local_notification_model.dart';

class HomeViewModel {
  final _localNotificationService = LocalNotificationManager.instance;

  Future<bool> showNotification() async {
    final localNotificationModel = LocalNotificationModel(
      id: Random().nextInt(10000),
      title: "Insant notification",
      body: "This is a test notification",
      payload: "Payload",
    );

    try {
      await _localNotificationService.showNotification(
        localNotificationModel,
      );
      return true;
    } catch (e) {
      debugPrint("Error while creating local notification $e");
      return false;
    }
  }

  Future<bool> showScheduledNotification() async {
    final localNotificationModel = LocalNotificationModel(
      id: Random().nextInt(10000),
      title: "Scheduled Notification",
      body: "This is a test notification",
      dateTime: DateTime.now().add(const Duration(seconds: 5)),
      payload: "Payload",
    );

    try {
      await _localNotificationService.showScheduledNotification(
        localNotificationModel,
      );
      return true;
    } catch (e) {
      debugPrint("Error while creating scheduled local notification $e");
      return false;
    }
  }

  Future<bool> showRecurringNotification() async {
    final localNotificationModel = LocalNotificationModel(
      id: Random().nextInt(10000),
      title: "Recurring  Notification",
      body: "This is a test notification",
      payload: "Payload",
    );

    try {
      await _localNotificationService.showRecurringNotification(
        localNotificationModel,
      );
      return true;
    } catch (e) {
      debugPrint("Error while creating recurring local notification $e");
      return false;
    }
  }

  Future<bool> cancelAllNotifications() async {
    try {
      await _localNotificationService.cancelAllNotifications();
      return true;
    } catch (e) {
      debugPrint("Error while cancelling local notifications $e");
      return false;
    }
  }
}
