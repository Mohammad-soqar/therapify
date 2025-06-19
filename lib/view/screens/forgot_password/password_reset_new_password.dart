import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/view/widgets/app_button.dart';

void showPasswordResetNewPassword(BuildContext context) {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    (context as Element).markNeedsBuild();
  }

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
                    "Create New password",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const VSpace(10),
                  const Text(
                      "Set the new password for your account so that you can login and access all the features."),
                  const VSpace(25),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: AppInputDecoration.roundInputDecoration(
                      context: context,
                      hintText: 'Password',
                      prefixIcon: Image.asset(
                        "assets/icons/key.png",
                        color: AppColors.getTextColor2(),
                      ),
                      suffixIcon: IconButton(
                        icon: Image.asset(
                          obscurePassword ? "assets/icons/eye_close.png" : "assets/icons/eye_open.png",
                          color: AppColors.getTextColor2(),
                          width: 18.w,
                        ),
                        onPressed: togglePasswordVisibility,
                      ),
                    ),
                    obscureText: obscurePassword,
                  ),
                  const VSpace(20),
                  TextFormField(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: AppInputDecoration.roundInputDecoration(
                      context: context,
                      hintText: 'Confirm Password',
                      prefixIcon: Image.asset(
                        "assets/icons/key.png",
                        color: AppColors.getTextColor2(),
                      ),
                      suffixIcon: IconButton(
                        icon: Image.asset(
                          obscurePassword ? "assets/icons/eye_close.png" : "assets/icons/eye_open.png",
                          color: AppColors.getTextColor2(),
                          width: 18.w,
                        ),
                        onPressed: togglePasswordVisibility,
                      ),
                    ),
                    obscureText: obscurePassword,
                  ),
                  const VSpace(20),
                  AppButton(
                      title: "Continue",
                      bgColor: AppColors.primaryColor,
                      onPress: () {
                        Get.back();
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
