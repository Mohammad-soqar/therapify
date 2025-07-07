import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/data/models/DoctorModel.dart'; // ✅ correct model
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/doctor/doctor_details_screen.dart';
import 'package:therapify/view/widgets/spacing.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem({super.key, required this.item, required this.onDelete});
  final DoctorModel item;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const DoctorDetailsScreen(), // ✅ navigate to details screen
          ),
        );
      },
      child: Dismissible(
        key: ValueKey(item.doctorId), // ✅ fixed key
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onDelete(),
        background: Container(
          margin: EdgeInsets.only(bottom: 15.h),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: AppColors.dangerColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(CupertinoIcons.delete,
              color: AppColors.whiteColor, size: 18.sp),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 15.h),
          padding:
              EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h, right: 10.w),
          decoration: BoxDecoration(
            color: AppColors.getContainerColor(),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 60.r,
              height: 60.r,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: item.imageUrl == null || item.imageUrl!.isEmpty
                  ? Icon(Icons.person,
                      size: 30.r, color: AppColors.primaryColor)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.person),
                      ),
                    ),
            ),
            title: Text(
              item.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.getTitleColor()),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VSpace(6.h),
                Text(
                  item.specialization ?? 'Specialization not available',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                VSpace(8.h),
                Row(
                  children: [
                    Icon(CupertinoIcons.star_fill,
                        color: AppColors.warningColor, size: 14.sp),
                    HSpace(5.w),
                    Text(
                      (item.rating ?? 0.0).toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.getTitleColor(),
                          ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(CupertinoIcons.delete,
                  color: AppColors.getTextColor2(), size: 18.sp),
              onPressed: onDelete,
            ),
          ),
        ),
      ),
    );
  }
}
