import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/view/widgets/spacing.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.index,
    required this.image,
    required this.title,
    required this.description,
  });

  final int index;
  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(padding: EdgeInsets.symmetric(horizontal: 30.w), child: Image.asset(image)),
          VSpace(50.h),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.4),
            textAlign: TextAlign.center,
          ),
          VSpace(20.h),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
