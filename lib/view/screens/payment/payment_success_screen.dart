import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/appointment/appointment_list_screen.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctor = Get.arguments['doctor'];
    final String selectedDate = Get.arguments['selectedDate'];
    final String selectedTime = Get.arguments['selectedTime'];
    final String patientId = Get.arguments['patientId'];

    final totalFee = doctor.consultationFee + doctor.consultationFee * 0.07 + 0.5;

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
              padding: EdgeInsets.all(20.r),
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
                    SizedBox(
                      width: 120.w,
                      height: 120.w,
                      child: Image.asset("assets/icons/success.png"),
                    ),
                    VSpace(10.h),
                    Text("Payment Success", style: Theme.of(context).textTheme.titleMedium),
                    VSpace(10.h),
                    Text(
                      "You have successfully booked an appointment with Dr. ${doctor.name}",
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
                                Icon(CupertinoIcons.calendar, size: 18.sp, color: AppColors.primaryColor),
                                HSpace(6.w),
                                Text(
                                  selectedDate,
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
                                  "\$${totalFee.toStringAsFixed(2)}",
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
                                  selectedTime,
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
              onPress: () => Get.to(() =>  AppointmentListScreen(patientId: patientId,)),
              bgColor: AppColors.primaryColor,
              width: double.infinity,
            ),
            VSpace(20.h),
            AppButton(
              title: "Return Home",
              onPress: () => Navigator.popUntil(context, (route) => route.isFirst),
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
