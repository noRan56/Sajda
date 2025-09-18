import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_text_style.dart';

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
      appBar: AppBar(
        title: Image.asset('assets/images/p.png', height: 50.h, width: 100.w),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ImageBackg(),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),

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
