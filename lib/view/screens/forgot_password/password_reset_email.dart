import 'package:therapify/view/screens/forgot_password/password_reset_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';

void showPasswordResetEmail(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Padding to adjust for keyboard
        ),
        child: Wrap(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              decoration: BoxDecoration(
                color: AppColors.getBackgroundColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.r),
                  topRight: Radius.circular(0.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Forgot Password",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const VSpace(10),
                  const Text(
                      "Enter your email for the verification process, we will send 4 digits code to your email."),
                  const VSpace(25),
                  TextFormField(
                    // controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: AppInputDecoration.roundInputDecoration(
                      context: context,
                      hintText: 'Email Address',
                      prefixIcon: Image.asset(
                        "assets/icons/mail.png",
                        color: AppColors.getTextColor2(),
                      ),
                    ),
                  ),
                  const VSpace(20),
                  AppButton(
                      title: "Continue",
                      bgColor: AppColors.primaryColor,
                      onPress: () {
                        Get.back();
                        showPasswordResetOTP(context);
                      },
                      width: double.infinity)
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
