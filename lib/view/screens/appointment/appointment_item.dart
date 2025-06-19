import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/data/static/doctor_data.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:ionicons/ionicons.dart';

class AppointmentItem extends StatelessWidget {
  const AppointmentItem({super.key, required this.item});
  final DoctorModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60.r,
              height: 60.r,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: Image.asset(
                  item.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            HSpace(15.w),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.getTitleColor()),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      VSpace(8.h),
                      Text(
                        item.specialty,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      VSpace(10.h),
                      Row(
                        children: [
                          Icon(
                            Ionicons.calendar_outline,
                            color: AppColors.getTextColor(),
                            size: 13.sp,
                          ),
                          HSpace(5.w),
                          Text(
                            "18 November, 2024",
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                          backgroundColor: AppColors.primaryColor.withAlpha((0.1 * 255).toInt()),
                          radius: 18.r,
                          child: Icon(CupertinoIcons.videocam_fill, color: AppColors.primaryColor, size: 24.sp)),
                      VSpace(20.h),
                      Container(
                        constraints: BoxConstraints(minWidth: 70.w),
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                            color: item.activeStatus != "Online"
                                ? AppColors.dangerColor.withAlpha((0.1 * 255).toInt())
                                : AppColors.successColor.withAlpha((0.1 * 255).toInt()),
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Text(
                          item.activeStatus != "Online" ? "Declined" : "Completed",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: item.activeStatus != "Online" ? AppColors.dangerColor : AppColors.successColor,
                                fontSize: 10.sp,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
