/*
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/signUpScreen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _obscurePassword = true;
  String initialCountry = 'RU';
  String phoneCode = '+7';
  bool isSeller = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.r),
          margin: EdgeInsets.only(top: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const VSpace(10),
              const Text("Hello there, log in to continue!"),
              const VSpace(50),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Full Name"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Full Name',
                      ),
                    ),
                    const VSpace(20),
                    const Text("Email Address"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        bool isValidEmail = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                        ).hasMatch(value);

                        if (!isValidEmail) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Email Address',
                      ),
                    ),
                    const VSpace(20),
                    const Text("Phone Number"),
                    VSpace(8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.getBorderColor(), width: 1.0),
                              borderRadius: BorderRadius.circular(10.r)),
                          width: 130.w,
                          height: 52.h,
                          padding: EdgeInsets.zero,
                          child: CountryCodePicker(
                            onChanged: (CountryCode countryCode) {
                              phoneCode = countryCode.dialCode.toString();
                              initialCountry = countryCode.code.toString();
                              debugPrint("phoneCode $phoneCode");
                              debugPrint("initialCountry $initialCountry");
                            },
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 7.h),
                            initialSelection: initialCountry,
                            favorite: const ['+39', 'FR'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: true,
                            boxDecoration: BoxDecoration(
                              color: AppColors.getContainerColor(),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: Utils.defaultBoxShadow(),
                            ),
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            searchStyle: Theme.of(context).textTheme.bodyMedium,
                            dialogTextStyle: Theme.of(context).textTheme.bodyMedium,
                            closeIcon: Icon(Ionicons.close_outline, size: 22.sp, color: AppColors.getTextColor()),
                            searchDecoration: AppInputDecoration.roundInputDecoration(
                              context: context,
                              hintText: 'Search',
                            ),
                          ),
                        ),
                        const HSpace(10),
                        Flexible(
                          child: TextFormField(
                            controller: _phoneNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field can not be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: AppInputDecoration.roundInputDecoration(
                              context: context,
                              hintText: 'Phone',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const VSpace(20),
                    const Text("Password"),
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
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Image.asset(
                            _obscurePassword ? "assets/icons/eye_close.png" : "assets/icons/eye_open.png",
                            color: AppColors.getTextColor2(),
                            width: 18.w,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    const VSpace(20),
                    const Text("Confirm Password"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Image.asset(
                            _obscurePassword ? "assets/icons/eye_close.png" : "assets/icons/eye_open.png",
                            color: AppColors.getTextColor2(),
                            width: 18.w,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    const VSpace(25),
                    AppButton(
                      title: "Sign Up".tr,
                      height: 50.h,
                      width: double.infinity,
                      bgColor: AppColors.primaryColor,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          // authController.signUp(
                          //   isSeller ? "1" : "0",
                          //   _firstnameController.text,
                          //   _lastnameController.text,
                          //   _usernameController.text,
                          //   _emailController.text,
                          //   phoneCode,
                          //   _phoneNumberController.text,
                          //   _passwordController.text,
                          // );
                        }
                      },
                    ),
                    VSpace(20.h),
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
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.getBorderColor(),
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Image.asset(
                              "assets/icons/facebook.png",
                              width: 18.r,
                            ),
                          ),
                        ),
                        HSpace(20.w),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.getBorderColor(),
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Image.asset(
                              "assets/icons/google.png",
                              width: 18.r,
                            ),
                          ),
                        ),
                        HSpace(20.w),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.getBorderColor(),
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Image.asset(
                              "assets/icons/twitter.png",
                              width: 18.r,
                            ),
                          ),
                        )
                      ],
                    ),
                    VSpace(30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            "Sign In".tr,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.primaryColor),
                          ),
                        )
                      ],
                    ),
                    VSpace(30.h),
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
*/
