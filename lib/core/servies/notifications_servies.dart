import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController =
      StreamController.broadcast();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future init() async {
    const AndroidInitializationSettings android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const DarwinInitializationSettings iOS = DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );

    tz.initializeTimeZones();
  }

  static Future showBasicNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'basic_channel',
      'Basic Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(android: android);

    await flutterLocalNotificationsPlugin.show(
      0,
      'إشعار عادي',
      'هذا إشعار تجريبي',
      details,
      payload: "basic",
    );
  }

  /// ⏰
  static Future showScheduledNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails details = NotificationDetails(android: android);
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      1, // Schedule at 8:00 AM
      25,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'اذكار الصباح',
      ' لا تنس قراءة اذكار الصباح 🌅 ',
      scheduled,
      details,
      androidScheduleMode: AndroidScheduleMode.exact,
      payload: 'scheduled',
    );
  }

  static Future scheduleDailyAzkar() async {
    showScheduledNotification();
    showDailyAzkarNotification(
      id: 100,
      title: "أذكار الصباح",
      body: "🌅 لا تنس قراءة أذكار الصباح",
      hour: 11,
      minute: 20,
    );

    showDailyAzkarNotification(
      id: 101,
      title: "أذكار المساء",
      body: "🌇 لا تنس قراءة أذكار المساء",
      hour: 17,
      minute: 0,
    );
  }

  static Future showDailyAzkarNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'daily_channel',
      'Daily Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(android: android);

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      details,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'daily',
    );
  }
}
