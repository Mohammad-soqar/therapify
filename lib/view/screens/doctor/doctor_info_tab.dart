import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:readmore/readmore.dart';

class DoctorInfoTab extends StatelessWidget {
  const DoctorInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quick Overview", style: Theme.of(context).textTheme.titleMedium),
        VSpace(16.h),
        Container(
          padding: EdgeInsets.all(20.r),
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Ionicons.videocam, size: 18.sp, color: AppColors.primaryColor),
                  HSpace(6.w),
                  const Text("Instant Consultation Time"),
                ],
              ),
              VSpace(8.h),
              const Text("Mon (3 PM - 11.55 PM)"),
              VSpace(8.h),
              const Text("Wed (3 PM - 11.55 PM)"),
              VSpace(30.h),
              Row(
                children: [
                  Icon(Ionicons.calendar, size: 18.sp, color: AppColors.primaryColor),
                  HSpace(6.w),
                  const Text("Appointment Consultation Time"),
                ],
              ),
              VSpace(8.h),
              const Text("Mon - Wed (6 PM - 11 PM)"),
            ],
          ),
        ),
        VSpace(20.h),
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Consultation Fee",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      VSpace(8.h),
                      Text(
                        r"$20 (incl. VAT)",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                      ),
                      VSpace(20.h),
                      Text(
                        "Avg. Consultation time",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      VSpace(8.h),
                      Text(
                        "15 minutes",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Follow-up Fee",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      VSpace(8.h),
                      Text(
                        "\$10 (incl. VAT)",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                      ),
                      VSpace(20.h),
                      Text(
                        "Doctor Code",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      VSpace(8.h),
                      Text(
                        "DT6572",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        VSpace(30.h),
        Text("About Doctor", style: Theme.of(context).textTheme.titleMedium),
        VSpace(16.h),
        ReadMoreText(
          "Experienced and certified to practice medicine to help maintain or restore physical and mental health. A doctor interacts with patients, diagnosing medical problems and successfully treating illness or injury. There are many specific areas in the field of medicine that students can study. There are many specific areas in the field of medicine that students can study.",
          trimLines: 3,
          colorClickableText: AppColors.primaryColor,
          trimMode: TrimMode.Length,
          trimCollapsedText: 'Show more',
          trimExpandedText: ' Show less',
          lessStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
          moreStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
