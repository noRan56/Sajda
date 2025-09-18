import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/presentation_layer/view%20model/azkar_morring.dart';

class DuaaQurany extends StatelessWidget {
  const DuaaQurany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '✌️رحمة وشفاء',
          style: TextStyle(
            fontFamily: "Amiri",
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF007D62),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ImageBackg(),
          ListView.builder(
            itemCount: duaaQurany.length,
            itemBuilder: (context, index) {
              final dhikr = duaaQurany[index];
              return Column(
                children: [
                  SizedBox(height: 20.h),
                  Card(
                    color: CustomColors.green2,

                    child: ListTile(
                      title: Text(
                        dhikr.text,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: "Amiri",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "التكرار: ${dhikr.repeat}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Amiri",
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
