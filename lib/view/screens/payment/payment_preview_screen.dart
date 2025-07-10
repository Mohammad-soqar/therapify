import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/view/screens/payment/payment_success_screen.dart';

class PaymentPreviewScreen extends StatelessWidget {
  final DoctorModel doctor;
  final String selectedDate;
  final String selectedTime;
  final String patientId;

  const PaymentPreviewScreen({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    final double vat = doctor.consultationFee * 0.07;
    final double platformFee = 0.5;
    final double total = doctor.consultationFee + vat + platformFee;

    return Scaffold(
      appBar: const CustomAppbar(
        title: "Payment Details",
        leading: [GetBackButton()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            // Doctor Info
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100.r,
                    height: 100.r,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withAlpha(70),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.network(
                            (doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty)
                                ? doctor.imageUrl!
                                : "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
                            fit: BoxFit.contain,
                          ),
                    ),
                  ),
                  HSpace(15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.getTitleColor()),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        VSpace(8.h),
                        if (doctor.rating != null)
                          Row(
                            children: [
                              Icon(CupertinoIcons.star_fill, color: AppColors.warningColor, size: 14.sp),
                              HSpace(5.w),
                              Text(
                                "${doctor.rating!.toStringAsFixed(1)}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        VSpace(8.h),
                        if (doctor.category != null)
                          Text(
                            doctor.category!,
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

            VSpace(20.h),

            // Appointment Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Appointment Info", style: Theme.of(context).textTheme.titleMedium),
                  VSpace(10.h),
                  Text("Patient: $patientId"),
                  Text("Date: $selectedDate"),
                  Text("Time: $selectedTime"),
                ],
              ),
            ),

            VSpace(30.h),

            // Payment Info
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Details", style: Theme.of(context).textTheme.titleMedium),
                  VSpace(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Consultation Fee"),
                      Text("\$${doctor.consultationFee.toStringAsFixed(2)}"),
                    ],
                  ),
                  VSpace(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("VAT (7%)"),
                      Text("\$${vat.toStringAsFixed(2)}", style: TextStyle(color: AppColors.dangerColor)),
                    ],
                  ),
                  VSpace(10.h),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Platform Fee"), Text(r"$0.50")],
                  ),
                  VSpace(10.h),
                  const DottedLine(dashLength: 5),
                  VSpace(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total", style: Theme.of(context).textTheme.bodyLarge),
                      Text("\$${total.toStringAsFixed(2)}", style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ],
              ),
            ),

            VSpace(25.h),
            AppButton(
              title: "Payment Now",
              onPress: () {
                Get.to(
                  () => const PaymentSuccessScreen(),
                  arguments: {
                    'doctor': doctor,
                    'selectedDate': selectedDate,
                    'selectedTime': selectedTime,
                    'patientId': patientId,
                  },
                );
              },
              bgColor: AppColors.primaryColor,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
