import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/data/models/AppointmentModel.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:ionicons/ionicons.dart';

class AppointmentItemReal extends StatelessWidget {
  const AppointmentItemReal({super.key, required this.item});
  final AppointmentModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: AppColors.getContainerColor(),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            child: Icon(Icons.person, color: AppColors.primaryColor, size: 28.r),
          ),
          HSpace(15.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Doctor & Time Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. ${item.doctorName}", // Replace with lookup later
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.getTitleColor(),
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VSpace(6.h),
                    Text(
                      "Date: ${item.appointmentDate}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    VSpace(4.h),
                    Text(
                      "Time: ${item.appointmentTime}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),

                // Status & Call
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      radius: 18.r,
                      child: Icon(
                        CupertinoIcons.videocam_fill,
                        color: AppColors.primaryColor,
                        size: 22.sp,
                      ),
                    ),
                    VSpace(20.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        "Pending", // Or Completed/Cancelled based on future status
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.successColor,
                              fontSize: 10.sp,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
