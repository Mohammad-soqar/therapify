import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/data/static/doctor_data.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:therapify/view/widgets/spacing.dart';

class DoctorItem extends StatelessWidget {
  const DoctorItem({super.key,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //TODO : Navigate to doctor details screen with the item data
      onTap: () => Get.toNamed(RoutesName.doctorDetailsScreen, arguments: item),
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 60.r,
                height: 60.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
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
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(CupertinoIcons.star_fill, color: AppColors.warningColor, size: 14.sp),
                            HSpace(5.w),
                            Text(
                              item.averageRating.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 14.sp, color: AppColors.getTitleColor()),
                            ),
                          ],
                        ),
                        VSpace(10.h),
                        Container(
                          constraints: BoxConstraints(minWidth: item.activeStatus != "Online" ? 120.w : 50.w),
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                              color: item.activeStatus != "Online"
                                  ? AppColors.primaryColor.withAlpha((0.1 * 255).toInt())
                                  : AppColors.successColor.withAlpha((0.1 * 255).toInt()),
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Text(
                            item.activeStatus,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color:
                                      item.activeStatus != "Online" ? AppColors.primaryColor : AppColors.successColor,
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
      ),
    );
  }
}
