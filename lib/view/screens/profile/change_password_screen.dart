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
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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
                    return 'Please enter your password';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: "Current Password",
                  borderColor: AppColors.getContainerColor(),
                  fillColor: AppColors.getContainerColor(),
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Image.asset(
                      _obscurePassword ? "assets/icons/eye_close.png" : "assets/icons/eye_open.png",
                      color: AppColors.getTextColor2(),
                      width: 18.w,
                    ),
                  ),
                ),
                obscureText: _obscurePassword,
              ),
              VSpace(20.h),
              const Text("New Password"),
              VSpace(8.h),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: "New Password",
                  borderColor: AppColors.getContainerColor(),
                  fillColor: AppColors.getContainerColor(),
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Image.asset(
                      _obscurePassword ? "assets/icons/eye_close.png" : "assets/icons/eye_open.png",
                      color: AppColors.getTextColor2(),
                      width: 18.w,
                    ),
                  ),
                ),
                obscureText: _obscurePassword,
              ),
              VSpace(20.h),
              const Text("Confirm New Password"),
              VSpace(8.h),
              TextFormField(
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: "Confirm New Password",
                  borderColor: AppColors.getContainerColor(),
                  fillColor: AppColors.getContainerColor(),
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Image.asset(
                      _obscurePassword ? "assets/icons/eye_close.png" : "assets/icons/eye_open.png",
                      color: AppColors.getTextColor2(),
                      width: 18.w,
                    ),
                  ),
                ),
                obscureText: _obscurePassword,
              ),
              SizedBox(height: 25.h),
              Center(
                child: AppButton(
                  title: "Update Password".tr,
                  height: 50.h,
                  width: double.infinity,
                  bgColor: AppColors.primaryColor,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {}
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
