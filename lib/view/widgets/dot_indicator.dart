import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 3.h,
      width: isActive ? 30.w : 30.w,
      decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : AppColors.getBorderColor(),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.w, color: isActive ? AppColors.primaryColor : Colors.transparent)),
    );
  }
}
