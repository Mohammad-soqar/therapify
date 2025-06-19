import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/data/static/notification_data.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.item});
  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
      leading: SizedBox(
        width: 40.r,
        height: 40.r,
        child: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withAlpha((0.2 * 255).toInt()),
          child: Image.asset(
            item.image,
            width: 18.w,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      title: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        child: Text(
          item.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      subtitle: Text(
        item.message,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VSpace(5.h),
          Text(
            item.time,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
