import 'package:therapify/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:get/get.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({super.key, required this.cartCount});

  final int cartCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RoutesName.doctorListScreen),
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
            color: AppColors.getContainerColor(),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: AppColors.primaryColor.withAlpha((0.1 * 255).toInt()))),
        child: Stack(
          children: [
            Image.asset(
              "assets/icons/wishlist.png",
              width: 22.w,
              color: AppColors.getTitleColor(),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 12.r,
                height: 12.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Text(
                  cartCount.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10.sp, color: AppColors.whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
