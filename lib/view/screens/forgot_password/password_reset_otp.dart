import 'package:therapify/view/screens/forgot_password/password_reset_new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/spacing.dart';

void showPasswordResetOTP(BuildContext context) {
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
                    "Enter your OTP code",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const VSpace(10),
                  const Text("Enter the 4 digits code that you received on your email"),
                  const VSpace(25),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    length: 4,
                    onCompleted: (pin) {
                      // controller.validationCodeController.text = pin;
                    },
                    defaultPinTheme: PinTheme(
                      width: 48.r,
                      height: 48.r,
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      decoration: BoxDecoration(
                        border: const Border(
                          bottom: BorderSide(
                            color: Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                        color: AppColors.primaryColor.withAlpha((0.1 * 255).toInt()),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 48.r,
                      height: 48.r,
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2.0,
                          ),
                        ),
                        color: AppColors.primaryColor.withAlpha((0.1 * 255).toInt()),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  const VSpace(30),
                  AppButton(
                      title: "Continue",
                      bgColor: AppColors.primaryColor,
                      onPress: () {
                        Get.back();
                        showPasswordResetNewPassword(context);
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
