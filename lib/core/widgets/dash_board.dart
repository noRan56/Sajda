import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardCard extends StatelessWidget {
  final double width;
  final double height;
  final LinearGradient gradientColors;
  final VoidCallback onTap;
  final Widget child;

  const DashboardCard({
    super.key,
    required this.width,
    required this.height,
    required this.gradientColors,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              spreadRadius: 7.r,
              offset: const Offset(1.5, 3),
              blurRadius: 5.r,
            ),
          ],
          image: const DecorationImage(
            image: AssetImage('assets/images/dashboard.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradientColors,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: child,
        ),
      ),
    );
  }
}
