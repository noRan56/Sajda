import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/styles/custom_text_style.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/presentation_layer/view%20model/azkar_morring.dart';

class SleepAzker extends StatelessWidget {
  const SleepAzker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.white,
        title: Text(" 💤أذكار قبل النوم ", style: CustomTextStyle.titleAppBar),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ImageBackg(),

          ListView.builder(
            itemCount: sleepAdhkar.length,
            itemBuilder: (context, index) {
              final dhikr = sleepAdhkar[index];
              return Column(
                children: [
                  SizedBox(height: 10.h),
                  Card(
                    color: CustomColors.green2,
                    child: ListTile(
                      title: Text(
                        dhikr.text,
                        textAlign: TextAlign.right,
                        style: CustomTextStyle.fontAzkar,
                      ),
                      subtitle: Text(
                        "التكرار: ${dhikr.repeat}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: "Amiri",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
