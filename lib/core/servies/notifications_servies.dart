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
      '@mipmap/launcher_icon',
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
    await showDailyAzkarNotification(
      id: 103,
      title: " يوم جديد يا حبيبي 😉",
      body:
          "كل صباح، أذكر نفسي، أن أتمسك بما أستطيع، ولا تنظر عيني إلى ما هو أبعد، كل صباح، أذكر نفسي، أني لا أملك نتيجة، ولا أتحكم في مصير، وأن علي احترام ضعفي ومحدوديتي وبشريتي، كل صباح أحاول من جديد، أحاول أن أجعل ذنبي أقل حدة، وأن أزيد مساحة قبولي لتلك الأخطاء التي ارتكبتها وأرتكبها، كل صباح أفتش عن الأمل، كأني لم أفتش عنه مطلقًا",
      hour: 9,
      minute: 30,
    );
    await showDailyAzkarNotification(
      id: 104,
      title: '🔻لن نترك غزة وحدها🔻',
      body:
          'اللَّهُمَّ مُنْزِلَ الكِتَابِ، ومُجْرِيَ السَّحَابِ، وهَازِمَ الأحْزَابِ، اهْزِم الصها..،..ينة وانْصُرْنَا عليهم',
      hour: 15,
      minute: 0,
    );
    await showWeeklyNotification(
      id: 200,
      title: "📖 تذكير أسبوعي",
      body: "لا تنس قراءة سورة الكهف اليوم 🌿",
      weekday: DateTime.friday, // Friday
      hour: 9,
      minute: 30,
    );
    await showWeeklyNotification(
      id: 201,
      title: "📖 تذكير أسبوعي",
      body: "لا تنس الصلاة على الحبيب",
      weekday: DateTime.friday, // Friday
      hour: 15,
      minute: 35,
    );
    await showWeeklyNotification(
      id: 200,
      title: "دعاء مجاب !🤲",
      body: "نذكركم بأن الدعاء بين الظهر والعصر مستجاب يوم الأربعاء ",
      weekday: DateTime.wednesday,
      hour: 13,
      minute: 20,
    );
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

      // Create scheduled time in local timezone
      tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      // If the scheduled time is already passed, set for next day
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
        // print('Adjusted scheduled time (next day): $scheduledDate');
      }

      // print('Final scheduled time: $scheduledDate');

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

      // print('Notification $id scheduled successfully');
    } catch (e) {
      // print('Error scheduling notification: $e');
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

  static Future<void> showWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required int weekday, // 1 = Monday, 7 = Sunday
    required int hour,
    required int minute,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);

      const AndroidNotificationDetails android = AndroidNotificationDetails(
        'weekly_channel',
        'Weekly Notifications',
        channelDescription: 'Weekly reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      );

      const DarwinNotificationDetails iOS = DarwinNotificationDetails(
        categoryIdentifier: 'weekly_category',
        presentAlert: true,
        presentSound: true,
      );

      const NotificationDetails details = NotificationDetails(
        android: android,
        iOS: iOS,
      );

      final now = tz.TZDateTime.now(tz.local);

      // First scheduled date (this week)
      tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      // Adjust to the correct weekday
      while (scheduledDate.weekday != weekday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // If it's already passed for today, push to next week
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 7));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: 'weekly_$id',
      );
    } catch (e) {
      print('Error scheduling weekly notification: $e');
    }
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
