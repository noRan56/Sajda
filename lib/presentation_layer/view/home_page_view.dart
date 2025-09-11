import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/servies/notifications_servies.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/presentation_layer/view/azkar_list_page.dart';
import 'package:sajda/presentation_layer/view/bookmark_page.dart';
import 'package:sajda/presentation_layer/view/prayer_time_page.dart';
import 'package:sajda/presentation_layer/view/surah_page.dart';

import 'package:timezone/timezone.dart' as tz;

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sajda', style: TextStyle(color: Colors.teal)),
          centerTitle: true,
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ],
          leading: Icon(Icons.menu, color: Colors.teal),
        ),
        body: Stack(
          children: [
            ImageBackg(),

            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),

                    Center(
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                        height: 100.h,
                        width: 100.w,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 330.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              spreadRadius: 7.r,
                              offset: Offset(1.5, 3),
                              blurRadius: 5.r,
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/images/dashboard.png'),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.teal.shade400,
                                Colors.teal.shade600,
                                Colors.tealAccent.shade200,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 20.w),
                              Text(
                                'Duaa',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              Image.asset('assets/images/lamp.png'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SurahListScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 150.w,
                            height: 150.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  spreadRadius: 7.r,
                                  offset: Offset(1.5, 3),
                                  blurRadius: 5.r,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/dashboard.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green.shade400,
                                    Colors.green.shade600,
                                    Colors.greenAccent.shade200,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20.h),
                                  Image.asset(
                                    'assets/images/quran1.png',
                                    height: 60.h,
                                    width: 60.w,
                                  ),
                                  SizedBox(height: 30.h),
                                  Text(
                                    'Quran',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PrayerTimeScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 160.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  spreadRadius: 7.r,
                                  offset: Offset(1.5, 3),
                                  blurRadius: 5.r,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/dashboard.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purple.shade400,
                                    Colors.purple.shade300,
                                    Colors.purple.shade600,
                                    Colors.purple.shade800,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20.h),
                                  Image.asset(
                                    'assets/images/prayer.png',
                                    height: 60.h,
                                    width: 60.w,
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'Prayer Times',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FavoritesScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 130.w,
                            height: 170.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  spreadRadius: 7.r,
                                  offset: Offset(1.5, 3),
                                  blurRadius: 5.r,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/dashboard.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange.shade400,
                                    Colors.orange.shade300,
                                    Colors.orange.shade600,
                                    Colors.orange.shade800,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  Image.asset(
                                    'assets/images/bookmark.png',
                                    width: 60.w,
                                    height: 60.h,
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.all(12.0.w.h),
                                    child: Text(
                                      'Bookmark',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AzkarListPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 190.w,
                            height: 140.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  spreadRadius: 7.r,
                                  offset: Offset(1.5, 3),
                                  blurRadius: 5.r,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/dashboard.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pink.shade200,
                                    Colors.pink.shade300,
                                    Colors.pink.shade400,
                                    Colors.pink.shade500,
                                    Colors.pink.shade600,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.all(8.0.h.w),
                                    child: Image.asset(
                                      'assets/images/moon.png',
                                      width: 60.w,
                                      height: 60.h,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.w),
                                    child: Text(
                                      'Azkar',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
