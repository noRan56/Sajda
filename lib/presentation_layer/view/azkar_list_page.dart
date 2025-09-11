import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/widgets/evening_azkar.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/core/widgets/morening_azkar_widget.dart';
import 'package:sajda/core/widgets/sleeping_azkar.dart';
import 'package:sajda/core/widgets/tasbeeh_widget.dart';
import 'package:sajda/presentation_layer/view/azkar_page_view.dart';
import 'package:sajda/presentation_layer/view/evening_azkar.dart';
import 'package:sajda/presentation_layer/view/sleep_azker.dart';
import 'package:sajda/presentation_layer/view/tasbeeh_view.dart';
import 'package:sajda/presentation_layer/view/wake_up_Azkar.dart';

class AzkarListPage extends StatelessWidget {
  const AzkarListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("اذكار"), centerTitle: true),

      body: Stack(
        children: [
          ImageBackg(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.w.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.h),
                  TasbeehWidget(),
                  SizedBox(height: 20.h),
                  MoreningAzkarWidget(),
                  SizedBox(height: 20.h),
                  EvenningAzkar(),
                  SizedBox(height: 20.h),
                  SleepingAzkar(),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => WakeUpAzkar()),
                      );
                      // EveningAzkar
                    },
                    child: Container(
                      height: 70.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.teal.shade200,
                            Colors.teal.shade300,
                            Colors.teal.shade400,
                            Colors.teal.shade500,
                            Colors.teal.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w),
                          Image.asset(
                            'assets/images/alarm.png',
                            height: 70.h,
                            width: 70.w,
                          ),
                          SizedBox(width: 70.w),
                          Text(
                            'أذكارالإستيقاظ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
