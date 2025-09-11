import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/presentation_layer/view%20model/azkar_morring.dart';

class WakeUpAzkar extends StatelessWidget {
  const WakeUpAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: afterWakeUp.length,
        itemBuilder: (context, index) {
          final dhikr = afterWakeUp[index];
          return Stack(
            children: [
              ImageBackg(),

              Card(
                color: Colors.teal,
                child: ListTile(
                  title: Text(
                    dhikr.text,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
    );
  }
}
