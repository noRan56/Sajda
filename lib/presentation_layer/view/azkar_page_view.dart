import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/presentation_layer/view%20model/azkar_morring.dart';

class AzkarPageView extends StatelessWidget {
  const AzkarPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اذكار الصباح",
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
            itemCount: morningAdhkar.length,
            itemBuilder: (context, index) {
              final dhikr = morningAdhkar[index];
              return Column(
                children: [
                  SizedBox(height: 20.h),
                  Card(
                    color: Color(0xFF2A6E3F),

                    child: ListTile(
                      title: Text(
                        dhikr.text,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
