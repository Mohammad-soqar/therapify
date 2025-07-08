import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/doctor/doctor_details_screen.dart';
import 'package:therapify/view/widgets/spacing.dart';

class DoctorItem extends StatelessWidget {
  final DoctorModel item;

  const DoctorItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
onTap: () {
  Get.to(() => const DoctorDetailsScreen(), arguments: item);
},
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: AppColors.getContainerColor(),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Container(
              width: 60.r,
              height: 60.r,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: item.imageUrl == null || item.imageUrl!.isEmpty
                  ? Icon(Icons.person, size: 30.r, color: AppColors.primaryColor)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.person),
                      ),
                    ),
            ),
            HSpace(15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.getTitleColor(),
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  VSpace(8.h),
                  Text(
                    item.specialization ?? 'Specialization not available',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
