import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';

class KycItem extends StatelessWidget {
  const KycItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: AppColors.getContainerColor(),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 5.h),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withAlpha((0 * 255).toInt()),
          child: Image.asset(
            "assets/icons/identity_verify.png",
            width: 24.w,
            color: AppColors.primaryColor,
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(bottom: 5.h),
          child: Text(
            "NID Submission",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        subtitle: Text(
          "#OID234SDF3",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Text(
          "10th sep, 2023",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
        ),
      ),
    );
  }
}
