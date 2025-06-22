// lib/view/screens/auth/sign_in_doctor_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:therapify/data/services/doctor_service.dart';
import 'package:therapify/view/screens/doctor_dashboard/doctor_dashboard_view.dart';

import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:therapify/view/screens/forgot_password/password_reset_email.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/view/screens/auth/signin_screen.dart';

class SignInDoctorScreen extends StatefulWidget {
  static const String routeName = "/signInDoctor";
  const SignInDoctorScreen({super.key});

  @override
  State<SignInDoctorScreen> createState() => _SignInDoctorScreenState();
}

class _SignInDoctorScreenState extends State<SignInDoctorScreen> {
  final _formKey            = GlobalKey<FormState>();
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword     = true;
  bool _isRemember          = false;

  final _doctorService      = DoctorService();

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  Future<void> _handleSignIn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    try {
      // 1️⃣ Sign in with Firebase Auth
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final uid = cred.user?.uid;
      if (uid == null) throw FirebaseAuthException(
        code: 'NO_USER',
        message: 'Authentication failed.',
      );

      // 2️⃣ Ensure doctor record exists
      await _doctorService.getDoctor(uid);

      // 3️⃣ Navigate into your existing dashboard view
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DoctorDashboardView()),
      );
    } catch (e) {
      final msg = e is FirebaseAuthException
          ? (e.message ?? e.code)
          : e.toString();
      Get.snackbar(
        'Login Failed',
        msg,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.r),
          margin: EdgeInsets.only(top: 150.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome Doctor", style: Theme.of(context).textTheme.titleLarge),
              const VSpace(10),
              const Text("Please sign in to continue"),
              const VSpace(50),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email
                    const Text("Email"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _emailController,
                      validator: (v) => (v?.isEmpty ?? true) ? 'Enter email' : null,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Email Address',
                      ),
                    ),
                    VSpace(30.h),

                    // Password
                    const Text("Password"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: (v) => (v?.isEmpty ?? true) ? 'Enter password' : null,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Password',
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

                    // Remember & Forgot
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: .9,
                              child: Checkbox(
                                value: _isRemember,
                                onChanged: (val) => setState(() => _isRemember = val ?? false),
                                checkColor: AppColors.whiteColor,
                                activeColor: AppColors.primaryColor,
                              ),
                            ),
                            Text("Remember me", style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        InkWell(
                          onTap: () => showPasswordResetEmail(context),
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        )
                      ],
                    ),
                    VSpace(40.h),

                    // Sign In Button
                    AppButton(
                      title: "Sign In".tr,
                      width: double.infinity,
                      bgColor: AppColors.primaryColor,
                      onPress: _handleSignIn,
                    ),

                    // Link to patient login
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignInScreen()),
                      ),
                      child: Text(
                        "Log in as patient",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),

                    VSpace(50.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        InkWell(
                          onTap: () => Get.toNamed(RoutesName.signUpScreen),
                          child: Text(
                            "Sign Up".tr,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                    VSpace(20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
