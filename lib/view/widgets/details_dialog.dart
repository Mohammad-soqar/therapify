import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';

class DetailsDialog extends StatelessWidget {
  const DetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      titlePadding: EdgeInsets.all(0.w),
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Details",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          RichText(
            text: TextSpan(
              text: "Start Time: 0 - 12 hours",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              text: "Guarantee: The delivery is Guaranteed",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              text:
                  "Quality: All comments are from accounts with 100k+ Followers 📌 3 comments (per 1000 order quantity) ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              text: "Profile Quality Example: https://www.instagram.com/the_awesome_people_insta",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
