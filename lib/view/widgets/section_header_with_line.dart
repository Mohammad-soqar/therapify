import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';

class SectionHeaderWithLine extends StatelessWidget {
  final String title;
  final double spacing;
  final double lineHeight;

  const SectionHeaderWithLine({
    super.key,
    required this.title,
    this.spacing = 15.0,
    this.lineHeight = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(width: spacing.w),
        Expanded(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                AppColors.getBorderColor().withAlpha((1 * 255).toInt()), // Full opacity on left
                AppColors.getBorderColor().withAlpha((0 * 255).toInt()), // Transparent on right
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Container(
              height: lineHeight.h,
              color: AppColors.getBorderColor(),
            ),
          ),
        ),
      ],
    );
  }
}
