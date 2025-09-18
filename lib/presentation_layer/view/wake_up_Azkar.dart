import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/styles/custom_text_style.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/presentation_layer/view%20model/azkar_morring.dart';

class WakeUpAzkar extends StatelessWidget {
  const WakeUpAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اذكار الاستيقاظ",
          style: TextStyle(
            fontFamily: "Amiri",
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ImageBackg(),
          afterWakeUp == null || afterWakeUp.isEmpty
              ? Center(child: Text("لا يوجد أذكار"))
              : ListView.builder(
                itemCount: afterWakeUp.length,
                itemBuilder: (context, index) {
                  final dhikr = afterWakeUp[index];
                  return Column(
                    children: [
                      SizedBox(height: 40.h),
                      Card(
                        color: CustomColors.green4,
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
