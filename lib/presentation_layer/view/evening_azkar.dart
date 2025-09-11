import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/presentation_layer/view%20model/azkar_morring.dart';

class EveningAzkar extends StatelessWidget {
  const EveningAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("اذكار "), centerTitle: true),
      body: ListView.builder(
        itemCount: eveningAdhkar.length,
        itemBuilder: (context, index) {
          final dhikr = eveningAdhkar[index];
          return Card(
            color: Colors.teal,
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
          );
        },
      ),
    );
  }
}
