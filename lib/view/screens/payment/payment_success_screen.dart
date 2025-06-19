import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Payment Success",
        leading: [GetBackButton()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 20.h),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/success_bg.png"),
                  colorFilter: ColorFilter.mode(
                    AppColors.getContainerColor(),
                    BlendMode.srcATop,
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Column(
                  children: [
                    VSpace(20.h),
                    SizedBox(width: 120.w, height: 120.w, child: Image.asset("assets/icons/success.png")),
                    VSpace(10.h),
                    Text("Payment Success", style: Theme.of(context).textTheme.titleMedium),
                    VSpace(10.h),
                    const Text(
                      "You have successfully booked on appoinment with Dr. Roland L. Jessen",
                      textAlign: TextAlign.center,
                    ),
                    VSpace(90.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(CupertinoIcons.person, size: 18.sp, color: AppColors.primaryColor),
                                HSpace(6.w),
                                Text(
                                  "John J. Grubbs",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                            VSpace(15.h),
                            Row(
                              children: [
                                Icon(CupertinoIcons.calendar, size: 18.sp, color: AppColors.primaryColor),
                                HSpace(6.w),
                                Text(
                                  "16 July, 2024",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/icons/wallet.png", width: 18.w, color: AppColors.primaryColor),
                                HSpace(6.w),
                                Text(
                                  "20.053 USD",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                            VSpace(15.h),
                            Row(
                              children: [
                                Icon(CupertinoIcons.clock, size: 18.sp, color: AppColors.primaryColor),
                                HSpace(6.w),
                                Text(
                                  "10.00 AM",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    VSpace(30.h),
                  ],
                ),
              ),
            ),
            VSpace(30.h),
            AppButton(
              title: "See Appointment",
              onPress: () => Get.toNamed(RoutesName.appointmentListScreen),
              bgColor: AppColors.primaryColor,
              width: double.infinity,
            ),
            VSpace(20.h),
            AppButton(
              title: "Return Home",
              onPress: () => Get.offAllNamed(RoutesName.bottomNavScreen),
              bgColor: AppColors.getContainerColor(),
              width: double.infinity,
              textColor: AppColors.getTitleColor(),
            ),
          ],
        ),
      ),
    );
  }
}
