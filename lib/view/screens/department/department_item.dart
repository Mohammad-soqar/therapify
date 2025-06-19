import 'package:therapify/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/data/static/department_data.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:get/get.dart';

class DepartmentItem extends StatelessWidget {
  const DepartmentItem({super.key, required this.item});
  final Department item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RoutesName.doctorListScreen);
      },
      child: Container(
        constraints: BoxConstraints(minWidth: 90.w),
        height: 80.r,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(item.image),
            const VSpace(10),
            Text(
              item.title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 13.sp),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
