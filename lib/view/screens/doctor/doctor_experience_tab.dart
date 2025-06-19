import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/data/static/doctor_data.dart';

class DoctorExperienceTab extends StatelessWidget {
  final List<Experience> experienceList;

  const DoctorExperienceTab({super.key, required this.experienceList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Experience", style: Theme.of(context).textTheme.titleMedium),
        VSpace(16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: experienceList.length,
          itemBuilder: (context, index) {
            final experience = experienceList[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.jobPlace,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp),
                  ),
                  VSpace(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Designation", style: Theme.of(context).textTheme.bodySmall),
                          VSpace(8.h),
                          Text(
                            experience.designation,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp),
                          ),
                          VSpace(20.h),
                          Text("Employment Status", style: Theme.of(context).textTheme.bodySmall),
                          VSpace(8.h),
                          Text(
                            experience.employmentStatus,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Department", style: Theme.of(context).textTheme.bodySmall),
                          VSpace(8.h),
                          Text(
                            experience.department,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                          ),
                          VSpace(20.h),
                          Text("Period", style: Theme.of(context).textTheme.bodySmall),
                          VSpace(8.h),
                          Text(
                            experience.period,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
