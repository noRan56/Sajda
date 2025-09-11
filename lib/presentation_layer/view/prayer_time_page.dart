import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sajda/core/widgets/image_backg.dart';

import 'package:sajda/presentation_layer/view%20model/home_view_model.dart';
import 'package:sajda/presentation_layer/view/home_page_view.dart';

class PrayerTimeScreen extends StatefulWidget {
  @override
  _PrayerTimeScreenState createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,

      body: Stack(
        children: [
          ImageBackg(),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/p.png',
                      height: 150.h,
                      width: 200.w,
                    ),
                    SizedBox(width: 20.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeViewPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15.w.h),
                        child: Image.asset(
                          'assets/images/arr.png',
                          height: 10.h,
                          width: 10.w,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(12.w.h),
                  child: Column(children: [HomeViewModel()]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
