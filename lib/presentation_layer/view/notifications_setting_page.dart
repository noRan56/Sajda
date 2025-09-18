import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/servies/notifications_servies.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  TimeOfDay? _morningTime;
  TimeOfDay? _eveningTime;
  TimeOfDay? _nightTime;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSavedTimes();
  }

  _loadSavedTimes() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      final morningHour = prefs.getInt('morningHour') ?? 7;
      final morningMinute = prefs.getInt('morningMinute') ?? 0;
      _morningTime = TimeOfDay(hour: morningHour, minute: morningMinute);

      final eveningHour = prefs.getInt('eveningHour') ?? 18;
      final eveningMinute = prefs.getInt('eveningMinute') ?? 0;
      _eveningTime = TimeOfDay(hour: eveningHour, minute: eveningMinute);

      final nightHour = prefs.getInt('nightHour') ?? 22;
      final nightMinute = prefs.getInt('nightMinute') ?? 0;
      _nightTime = TimeOfDay(hour: nightHour, minute: nightMinute);

      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  _selectMorningTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _morningTime ?? TimeOfDay(hour: 7, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );

    if (picked != null) {
      setState(() {
        _morningTime = picked;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('morningHour', picked.hour);
      await prefs.setInt('morningMinute', picked.minute);

      await LocalNotificationService.scheduleDailyAzkar();
    }
  }

  _selectEveningTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _eveningTime ?? TimeOfDay(hour: 18, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );

    if (picked != null) {
      setState(() {
        _eveningTime = picked;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('eveningHour', picked.hour);
      await prefs.setInt('eveningMinute', picked.minute);

      await LocalNotificationService.scheduleDailyAzkar();
    }
  }

  _selectSleepEveningTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _nightTime ?? TimeOfDay(hour: 22, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );

    if (picked != null) {
      setState(() {
        _nightTime = picked;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('nightHour', picked.hour);
      await prefs.setInt('nightMinute', picked.minute);

      await LocalNotificationService.scheduleDailyAzkar();
    }
  }

  _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);

    if (value) {
      await LocalNotificationService.scheduleDailyAzkar();
    } else {
      await LocalNotificationService.cancelAllNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إعدادات التنبيهات',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const ImageBackg(),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  activeColor: CustomColors.green2,
                  inactiveThumbColor: Colors.grey,
                  title: Text(
                    'تفعيل التنبيهات',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  value: _notificationsEnabled,
                  onChanged: _toggleNotifications,
                ),
                SizedBox(height: 20.h),
                if (_notificationsEnabled) ...[
                  _buildTimePickerTile(
                    context,
                    title: '🌅تنبيه أذكار الصباح',
                    time: _morningTime,
                    onTap: () => _selectMorningTime(context),
                  ),
                  SizedBox(height: 16.h),
                  _buildTimePickerTile(
                    context,
                    title: '🌙تنبيه أذكار المساء',
                    time: _eveningTime,
                    onTap: () => _selectEveningTime(context),
                  ),
                  SizedBox(height: 16.h),
                  _buildTimePickerTile(
                    context,
                    title: '💤 تنبيه قبل  النوم',
                    time: _nightTime,
                    onTap: () => _selectSleepEveningTime(context),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePickerTile(
    BuildContext context, {
    required String title,
    required TimeOfDay? time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey, width: 1.5),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 5.w),
            Column(
              children: [
                Icon(Icons.access_time, size: 24.w, color: Colors.teal),
                SizedBox(height: 8.h),
                Text(
                  time != null
                      ? '${time.hour}:${time.minute.toString().padLeft(2, '0')}'
                      : 'لم يتم التعيين',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(width: 116.w),
            Text(title, style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }
}
