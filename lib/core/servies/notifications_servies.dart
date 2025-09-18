import 'dart:async';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    // Initialize timezones first - this was missing
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    const AndroidInitializationSettings android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const DarwinInitializationSettings iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'daily_channel',
        'Daily Notifications',
        description: 'Daily reminder notifications',
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
    }
  }

  static Future<void> showDailyAzkarNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);

      const AndroidNotificationDetails android = AndroidNotificationDetails(
        'daily_channel',
        'Daily Notifications',
        channelDescription: 'Daily reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      );

      const DarwinNotificationDetails iOS = DarwinNotificationDetails(
        categoryIdentifier: 'daily_category',
        presentAlert: true,
        presentSound: true,
      );

      const NotificationDetails details = NotificationDetails(
        android: android,
        iOS: iOS,
      );

      // Get current time in local timezone
      final now = tz.TZDateTime.now(tz.local);
      print('Current local time: $now');

      // Create scheduled time in local timezone
      tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      print('Original scheduled time: $scheduledDate');

      // If the scheduled time is already passed, set for next day
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
        print('Adjusted scheduled time (next day): $scheduledDate');
      }

      print('Final scheduled time: $scheduledDate');

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'daily_$id',
      );

      print('Notification $id scheduled successfully');
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  static Future<void> scheduleDailyAzkar() async {
    final prefs = await SharedPreferences.getInstance();

    final morningHour = prefs.getInt('morningHour') ?? 7;
    final morningMinute = prefs.getInt('morningMinute') ?? 0;

    final eveningHour = prefs.getInt('eveningHour') ?? 18;
    final eveningMinute = prefs.getInt('eveningMinute') ?? 0;

    final nightHour = prefs.getInt('nightHour') ?? 22;
    final nightMinute = prefs.getInt('nightMinute') ?? 0;

    final notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;

    if (!notificationsEnabled) {
      await cancelAllNotifications();
      return;
    }

    await showDailyAzkarNotification(
      id: 100,
      title: "أذكار الصباح",
      body: "🌅 لا تنس قراءة أذكار الصباح",
      hour: morningHour,
      minute: morningMinute,
    );

    await showDailyAzkarNotification(
      id: 101,
      title: "أذكار المساء",
      body: "🌇 لا تنس قراءة أذكار المساء",
      hour: eveningHour,
      minute: eveningMinute,
    );
    await showDailyAzkarNotification(
      id: 102,
      title: " أذكار النوم",
      body: "😴 لا تنس قراءة أذكار النوم",
      hour: nightHour,
      minute: nightMinute,
    );
  }

  static Future<void> schedulePrayerNotifications(
    Map<String, String> prayerTimes,
  ) async {
    // Cancel existing notifications
    await cancelAllNotifications();

    // Schedule notifications for each prayer time
    final prayers = {
      'Fajr': 'الفجر',
      'Dhuhr': 'الظهر',
      'Asr': 'العصر',
      'Maghrib': 'المغرب',
      'Isha': 'العشاء',
    };

    int id = 0;
    for (var entry in prayers.entries) {
      final prayerTime = prayerTimes[entry.key];
      if (prayerTime != null) {
        await _scheduleNotification(
          id: id++,
          title: 'موعد الصلاة',
          body: 'حان الآن وقت صلاة ${entry.value}',
          prayerTime: prayerTime,
        );
      }
    }
  }

  static Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required String prayerTime,
  }) async {
    // Parse prayer time (format: "HH:mm")
    final timeParts = prayerTime.split(':');
    if (timeParts.length != 2) return;

    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);
    if (hour == null || minute == null) return;

    // Schedule notification for today at the prayer time
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // If the time has already passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'Prayer Times',
          channelDescription: 'Notifications for prayer times',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(sound: 'default'),
      ),

      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
