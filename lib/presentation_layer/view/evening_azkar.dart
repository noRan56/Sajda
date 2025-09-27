import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/styles/custom_text_style.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/presentation_layer/view%20model/azkar_morring.dart';

class EveningAzkar extends StatelessWidget {
  const EveningAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.white,
        title: Text("🌙 أذكار المساء 🌙 ", style: CustomTextStyle.titleAppBar),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ImageBackg(),
          ListView.builder(
            itemCount: eveningAdhkar.length,
            itemBuilder: (context, index) {
              final dhikr = eveningAdhkar[index];
              return Column(
                children: [
                  SizedBox(height: 10.h),

                  Card(
                    color: CustomColors.green1,
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
                          fontSize: 14.sp,
                          fontFamily: "Amiri",
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
