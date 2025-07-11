import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _updatePassword() async {
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Password Mismatch',
        'New password and confirmation do not match.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Re-authenticate with current password
      final cred = EmailAuthProvider.credential(
          email: user!.email!, password: currentPassword);
      await user.reauthenticateWithCredential(cred);

      // Update password
      await user.updatePassword(newPassword);

      Get.snackbar(
        'Success',
        'Password updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );

      _currentPasswordController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Change Password",
        leading: [GetBackButton()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Current Password"),
              VSpace(8.h),
              TextFormField(
                controller: _currentPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
                obscureText: _obscurePassword,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: "Current Password",
                  borderColor: AppColors.getContainerColor(),
                  fillColor: AppColors.getContainerColor(),
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Image.asset(
                      _obscurePassword
                          ? "assets/icons/eye_close.png"
                          : "assets/icons/eye_open.png",
                      color: AppColors.getTextColor2(),
                      width: 18.w,
                    ),
                  ),
                ),
              ),
              VSpace(20.h),
              const Text("New Password"),
              VSpace(8.h),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                obscureText: _obscurePassword,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: "New Password",
                  borderColor: AppColors.getContainerColor(),
                  fillColor: AppColors.getContainerColor(),
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Image.asset(
                      _obscurePassword
                          ? "assets/icons/eye_close.png"
                          : "assets/icons/eye_open.png",
                      color: AppColors.getTextColor2(),
                      width: 18.w,
                    ),
                  ),
                ),
              ),
              VSpace(20.h),
              const Text("Confirm New Password"),
              VSpace(8.h),
              TextFormField(
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  return null;
                },
                obscureText: _obscurePassword,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: "Confirm New Password",
                  borderColor: AppColors.getContainerColor(),
                  fillColor: AppColors.getContainerColor(),
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Image.asset(
                      _obscurePassword
                          ? "assets/icons/eye_close.png"
                          : "assets/icons/eye_open.png",
                      color: AppColors.getTextColor2(),
                      width: 18.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Center(
                child: AppButton(
                  title: "Update Password".tr,
                  height: 50.h,
                  width: double.infinity,
                  bgColor: AppColors.primaryColor,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      _updatePassword();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
