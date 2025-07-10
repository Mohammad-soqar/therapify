// bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/payment/payment_preview_screen.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/spacing.dart';

/// Shows the payment confirmation sheet
void showCustomModalBottomSheet(
  BuildContext context, {
  required DoctorModel doctor,
  required String selectedDate,
  required String selectedTime,
  required String patientId,        // ✅ NEW
}) {
  bool isRemember = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.getBackgroundColor(),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 30.h,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h,
        ),
        child: Wrap(
          children: [
            // Fee display
            Text("Consultation Fee", style: Theme.of(ctx).textTheme.bodyMedium),
            VSpace(8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                "${doctor.netConsultationFee.toStringAsFixed(2)} USD",
                style: Theme.of(ctx).textTheme.bodyMedium,
              ),
            ),
            VSpace(20.h),

            // Terms checkbox
            Row(
              children: [
                StatefulBuilder(
                  builder: (context, setState) {
                    return Checkbox(
                      value: isRemember,
                      onChanged: (val) =>
                          setState(() => isRemember = val ?? false),
                      activeColor: AppColors.primaryColor,
                    );
                  },
                ),
                Expanded(
                  child: Text(
                    "I agree to terms & condition",
                    style: Theme.of(ctx).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            VSpace(30.h),

            // Pay button
            AppButton(
              title: "Make Payment",
              width: double.infinity,
              bgColor: AppColors.primaryColor,
              onPress: () {
                Navigator.pushReplacement(
                  ctx,
                  MaterialPageRoute(
                    builder: (_) => PaymentPreviewScreen(
                      doctor: doctor,
                      selectedDate: selectedDate,
                      selectedTime: selectedTime,
                      patientId: patientId, 
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
