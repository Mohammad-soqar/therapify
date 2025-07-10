import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:readmore/readmore.dart';

class DoctorInfoTab extends StatelessWidget {
  final DoctorModel item;

  const DoctorInfoTab({super.key, required this.item});

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
          decoration: BoxDecoration(
            color: AppColors.getContainerColor(),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Ionicons.calendar, size: 18.sp, color: AppColors.primaryColor),
                  HSpace(6.w),
                  const Text("Appointment Consultation Time"),
                ],
              ),
              VSpace(8.h),
              Text("${item.availabilityDate} (${item.availabilityTime})"),
            ],
          ),
        ),
        VSpace(20.h),
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: AppColors.getContainerColor(),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Consultation Fee", style: Theme.of(context).textTheme.bodySmall),
                    VSpace(8.h),
                    Text(
                      "\$${item.consultationFee.toStringAsFixed(2)} (incl. VAT)",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                    ),
                    VSpace(20.h),
                    Text("Avg. Consultation Time", style: Theme.of(context).textTheme.bodySmall),
                    VSpace(8.h),
                    Text(
                      "${item.averageConsultationTime} minutes",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                    ),
                  ],
                ),
              ),
              HSpace(16.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Follow-up Fee", style: Theme.of(context).textTheme.bodySmall),
                    VSpace(8.h),
                    Text(
                      "\$${item.followUp.toStringAsFixed(2)} (incl. VAT)",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                    ),
                    VSpace(20.h),
                    
                    
                  ],
                ),
              ),
            ],
          ),
        ),
        VSpace(30.h),
        Text("About Doctor", style: Theme.of(context).textTheme.titleMedium),
        VSpace(16.h),
        ReadMoreText(
          item.bio ??
              "Experienced and certified to practice medicine to help maintain or restore physical and mental health.",
          trimLines: 3,
          colorClickableText: AppColors.primaryColor,
          trimMode: TrimMode.Length,
          trimCollapsedText: 'Show more',
          trimExpandedText: ' Show less',
          lessStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
          moreStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.getTextColor()),
        ),
      ],
    );
  }
}
