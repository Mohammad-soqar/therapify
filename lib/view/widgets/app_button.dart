import 'package:flutter/material.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.isLoading = false,
    required this.title,
    this.width = 100,
    this.height = 50,
    this.radius = 10,
    required this.onPress,
    this.textColor = AppColors.whiteColor,
    required this.bgColor,
    this.borderColor,
    this.icon,
  });

  final bool isLoading;
  final String title;
  final double width, height, radius;
  final VoidCallback onPress;
  final Color textColor, bgColor;
  final Color? borderColor;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor ?? bgColor),
          color: bgColor,
        ),
        child: !isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon != null
                      ? Container(margin: EdgeInsets.symmetric(horizontal: 5.w), child: icon)
                      : const SizedBox(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            : const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                    strokeWidth: 2.0,
                  ),
                ),
              ),
      ),
    );
  }
}
