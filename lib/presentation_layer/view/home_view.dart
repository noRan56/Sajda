import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/presentation_layer/view%20model/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.black,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/tobbar.png',
                height: 200.h,
                width: double.infinity,
              ),
              HomeViewModel(),
            ],
          ),
        ),
      ),
    );
  }
}
