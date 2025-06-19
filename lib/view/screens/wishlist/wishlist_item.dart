import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/data/static/doctor_data.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:therapify/view/widgets/spacing.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem({super.key, required this.item, required this.onDelete});
  final DoctorModel item;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RoutesName.doctorDetailsScreen, arguments: item),
      child: Dismissible(
        key: ValueKey(item.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          onDelete();
        },
        background: Container(
          margin: EdgeInsets.only(bottom: 15.h),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: AppColors.dangerColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(CupertinoIcons.delete, color: AppColors.whiteColor, size: 18.sp),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 15.h),
          child: Container(
            padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h, right: 10.w),
            decoration: BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(10.r)),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
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
              title: Text(
                item.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.getTitleColor()),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VSpace(6.h),
                  Text(
                    item.specialty,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  VSpace(8.h),
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
                ],
              ),
              trailing: IconButton(
                icon: Icon(CupertinoIcons.delete, color: AppColors.getTextColor2(), size: 18.sp),
                onPressed: onDelete,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
