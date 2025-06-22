// lib/view/screens/auth/sign_in_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:therapify/view/screens/auth/signin_doctor_screen.dart';
import 'package:therapify/view/screens/forgot_password/password_reset_email.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "/signInScreen";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isRemember = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = credential.user;
      if (user == null)
        throw FirebaseAuthException(
          code: 'USER_NOT_FOUND',
          message: 'No user found for this email.',
        );

      Navigator.of(context).pushReplacementNamed(RoutesName.bottomNavScreen);
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e is FirebaseAuthException
            ? e.message ?? 'Authentication error'
            : e.toString(),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome Back",
                  style: Theme.of(context).textTheme.titleLarge),
              const VSpace(10),
              const Text("Hello there, log in to continue!"),
              const VSpace(50),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Email"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your email'
                          : null,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Username or Email',
                      ),
                    ),
                    VSpace(30.h),
                    const Text("Password"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your password'
                          : null,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: "Password",
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
                      obscureText: _obscurePassword,
                    ),
                    const VSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: .9,
                              child: Checkbox(
                                checkColor: AppColors.whiteColor,
                                activeColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                                visualDensity: const VisualDensity(
                                  horizontal: -4.0,
                                  vertical: -4.0,
                                ),
                                side: BorderSide(
                                    color: AppColors.getBorderColor()),
                                value: _isRemember,
                                onChanged: (bool? value) {
                                  _isRemember = value!;
                                  setState(() {});
                                },
                              ),
                            ),
                            Text(
                              "Remember me",
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showPasswordResetEmail(context);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.primaryColor,
                                ),
                          ),
                        )
                      ],
                    ),
                    VSpace(40.h),

                    AppButton(
                      title: "Sign In".tr,
                      width: double.infinity,
                      bgColor: AppColors.primaryColor,
                      onPress: _handleSignIn,
                    ),

                    // 👇 doctor Login Text Link
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignInDoctorScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Log in as doctor",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),

                    VSpace(30.h),
                    Stack(
                      children: [
                        Divider(
                          height: 50.h,
                          color: AppColors.getBorderColor(),
                          thickness: 1,
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 14,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              color: AppColors.getBackgroundColor(),
                              child: const Text("Or sign in with"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    VSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final icon in ['facebook', 'google', 'twitter'])
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.getBorderColor()),
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: Image.asset("assets/icons/$icon.png",
                                    width: 18.r),
                              ),
                            ),
                          ),
                      ],
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.primaryColor,
                                ),
                          ),
                        )
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
