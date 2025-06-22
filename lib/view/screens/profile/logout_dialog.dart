import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/auth/signin_screen.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/spacing.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        Get.context!,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Logout Failed',
        e is FirebaseAuthException
            ? e.message ?? 'Authentication error'
            : e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      titlePadding: EdgeInsets.all(0.w),
      backgroundColor: AppColors.getBackgroundColor(),
      surfaceTintColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          RichText(
            text: TextSpan(
              text: "Are you leaving?",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              text: "Do you want to sign out?",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  width: 150.w,
                  height: 45.h,
                  title: "Cancel",
                  bgColor: AppColors.getContainerColor(),
                  textColor: AppColors.getTextColor(),
                  onPress: () {
                    Get.back();
                  },
                ),
              ),
              const HSpace(10),
              Expanded(
                child: AppButton(
                  width: 150.w,
                  height: 45.h,
                  title: "Yes, Log out",
                  bgColor: AppColors.primaryColor,
                  onPress: () {
                    _handleLogout();
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
