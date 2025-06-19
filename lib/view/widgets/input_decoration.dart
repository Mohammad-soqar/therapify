import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';

class AppInputDecoration {
  static InputDecoration flatInputDecoration({
    required BuildContext context,
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.getTextColor2()),
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.borderColor)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
      errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.dangerColor)),
      focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.dangerColor)),
      errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.dangerColor, fontSize: 12.sp),
      filled: true,
      fillColor: AppColors.whiteColor,
    );
  }

  static InputDecoration roundInputDecoration({
    required BuildContext context,
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor = Colors.transparent,
    Color borderColor = AppColors.borderColor,
    int borderRadius = 10,
  }) {
    if (borderColor == AppColors.borderColor) {
      borderColor = AppColors.getBorderColor();
    }
    return InputDecoration(
      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.getTextColor2(), fontSize: 14.sp),
      hintText: hintText,
      prefixIcon: prefixIcon != null
          ? Container(
              width: 40.w,
              padding: EdgeInsets.all(15.r),
              child: prefixIcon,
            )
          : null,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.dangerColor),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.dangerColor),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.dangerColor, fontSize: 10.sp),
      filled: true,
      fillColor: fillColor,
    );
  }
}
