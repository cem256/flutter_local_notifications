abstract class BaseLocalNotificationManager<T> {
  Future<void> initialize();
  Future<void> showNotification(T model);
  Future<void> showScheduledNotification(T model);
  Future<void> cancelAllNotifications();
  Future<void> cancelNotificationById(int id);
}
