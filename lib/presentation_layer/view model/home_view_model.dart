import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/servies/hive_service.dart';
import 'package:sajda/core/servies/location_services.dart';
import 'package:sajda/core/servies/notifications_servies.dart';
import 'package:sajda/core/styles/custom_text_style.dart';
import 'package:sajda/core/servies/api_service.dart';
import 'package:sajda/data_layer/models/prayer_time_model.dart';

class HomeViewModel extends StatefulWidget {
  const HomeViewModel({super.key});

  @override
  State<HomeViewModel> createState() => _HomeViewModelState();
}

class _HomeViewModelState extends State<HomeViewModel> {
  final ApiService apiService = ApiService();

  final TextEditingController cityController = TextEditingController(
    text: "Cairo",
  );
  final TextEditingController countryController = TextEditingController(
    text: "Egypt",
  );
  Future<PrayerTime>? _futurePrayerTime;
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
    // _initializeClock();
    /// الوقت
    clockHour = date.hour.toString();
    clockMinute = date.minute.toString();
    clockSecond = date.second.toString();
    showTime = '$clockHour:$clockMinute:$clockSecond';

    String hour = showTime.split(':')[0].padLeft(2, '0');
    String minute = showTime.split(':')[1].padLeft(2, '0');
    String second = showTime.split(':')[2].padLeft(2, '0');

    int hoursConvert = int.parse(hour);

    if (hoursConvert >= 12) {
      dateState = 'PM';
      if (hoursConvert > 12) {
        hoursConvert -= 12;
        hour = hoursConvert.toString().padLeft(2, '0');
      }
    } else {
      dateState = 'AM';
    }
    showTime = '$hour:$minute:$second : $dateState';

    /// API call
    _getPrayerTimes();
  }

  void _loadUserLocation() async {
    // Check if we have stored location
    final storedLocation = HiveService.getUserLocation();
    if (storedLocation != null) {
      setState(() {
        cityController.text = storedLocation['city'];
        countryController.text = storedLocation['country'];
      });
      _getPrayerTimes();
      return;
    }

    // Get current location
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final location = await LocationService.getCurrentLocation();
      setState(() {
        cityController.text = location['city']!;
        countryController.text = location['country']!;
        // Save location for future use
        HiveService.saveUserLocation(location['city']!, location['country']!);
      });
      _getPrayerTimes();
    } catch (e) {
      // Fallback to default location
      setState(() {
        cityController.text = 'Cairo';
        countryController.text = 'Egypt';
      });
      _getPrayerTimes();
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  DateTime date = DateTime.now();
  late String clockHour;
  late String clockMinute;
  late String clockSecond;
  late String dateState;
  String showTime = '';

  void _getPrayerTimes() {
    setState(() {
      _futurePrayerTime = apiService
          .fetchPrayerTimes(
            city: cityController.text.trim(),
            country: countryController.text.trim(),
          )
          .then((prayerTime) {
            LocalNotificationService.schedulePrayerNotifications({
              'Fajr': prayerTime.fajr,
              'Dhuhr': prayerTime.dhuhr,
              'Asr': prayerTime.asr,
              'Maghrib': prayerTime.maghrib,
              'Isha': prayerTime.isha,
            });
            return prayerTime;
          })
          .catchError((error) {
            print('Error fetching prayer times: $error');
            // You might want to show a snackbar or dialog here
            return PrayerTime(
              fajr: '--:--',
              dhuhr: '--:--',
              asr: '--:--',
              maghrib: '--:--',
              isha: '--:--',
            );
          });
    });
  }

  void _refreshPrayerTimes() {
    setState(() {
      _futurePrayerTime = apiService
          .fetchPrayerTimes(
            city: cityController.text.trim(),
            country: countryController.text.trim(),
            forceRefresh: true,
          )
          .then((prayerTime) {
            // Schedule notifications after getting prayer times
            LocalNotificationService.schedulePrayerNotifications({
              'Fajr': prayerTime.fajr,
              'Dhuhr': prayerTime.dhuhr,
              'Asr': prayerTime.asr,
              'Maghrib': prayerTime.maghrib,
              'Isha': prayerTime.isha,
            });
            return prayerTime;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40.w, right: 40.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: "المدينة",

                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: countryController,
              decoration: InputDecoration(
                labelText: "الدولة / المحافظة",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: _getPrayerTimes,
                  child: Container(
                    height: 40.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Center(
                      child: Text(
                        'عرض المواقيت',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _refreshPrayerTimes,
                  child: Container(
                    height: 40.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Center(
                      child: Text(
                        'تحديث',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 5.h),
            Center(child: Text(showTime, style: CustomTextStyle.font24Yellow)),
            SizedBox(height: 20.h),

            Text(
              'City : ${cityController.text}',
              style: CustomTextStyle.font20Yellow,
            ),
            Text(
              'Country : ${countryController.text}',
              style: CustomTextStyle.font20Yellow,
            ),
            Text(
              'Date: ${date.day} / ${date.month} / ${date.year}',
              style: CustomTextStyle.font20Yellow,
            ),
            SizedBox(height: 30.h),

            /// هنا دمجنا FutureBuilder
            FutureBuilder<PrayerTime>(
              future: _futurePrayerTime,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "خطأ: ${snapshot.error}",
                      style: CustomTextStyle.font18Yellow,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      "لا توجد بيانات",
                      style: CustomTextStyle.font18Yellow,
                    ),
                  );
                }

                final prayerTime = snapshot.data!;
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildRow("الفجر", prayerTime.fajr),
                    _buildRow("الظهر", prayerTime.dhuhr),
                    _buildRow("العصر", prayerTime.asr),
                    _buildRow("المغرب", prayerTime.maghrib),
                    _buildRow("العشاء", prayerTime.isha),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ... rest of your existing code for clock and UI

  Widget _buildRow(String title, String time) {
    return Column(
      children: [
        Row(
          children: [
            Text(time, style: CustomTextStyle.font18Yellow),
            const Spacer(),
            Text(
              title,
              style: CustomTextStyle.font18Yellow,
              textAlign: TextAlign.right,
            ),
          ],
        ),
        const Divider(indent: 10, endIndent: 10),
      ],
    );
  }
}
