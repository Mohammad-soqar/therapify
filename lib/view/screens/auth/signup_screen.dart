// lib/view/screens/auth/sign_up_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:therapify/data/models/patient.dart';
import 'package:therapify/data/models/user.dart';
import 'package:therapify/data/services/patient_service.dart';
import 'package:therapify/data/services/user_service.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/screens/home/home_screen.dart';
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
  final _formKey       = GlobalKey<FormState>();
  final _nameCtrl      = TextEditingController();
  final _emailCtrl     = TextEditingController();
  final _passwordCtrl  = TextEditingController();
  final _confirmCtrl   = TextEditingController();
  final _phoneCtrl     = TextEditingController();

  bool _obscurePassword = true;
  String initialCountry = 'RU';
  String phoneCode      = '+7';

  final _genders        = ['Male', 'Female', 'Other'];
  final _languages      = ['English', 'Türkçe', 'العربية'];
  String _selectedGender   = 'Male';
  String _selectedLanguage = 'English';

  final _patientService = PatientService();
  final _userService    = UserService();

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  Future<void> _onSignUpPressed() async {
  if (!_formKey.currentState!.validate()) return;

  try {
    // 1️⃣ Create the Auth user
    final cred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );

    final user = cred.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'NO_USER',
        message: 'Failed to create user credential.',
      );
    }
    final uid = user.uid;

    // 2️⃣ Save UserModel
    await _userService.saveUser(
      UserModel(
        name:        _nameCtrl.text.trim(),
        dob:         DateTime.now(),
        phoneNumber: '$phoneCode${_phoneCtrl.text.trim()}',
        role:        'patient',
        gender:      _selectedGender,
        email:       _emailCtrl.text.trim(),
        country:     initialCountry,
        language:    _selectedLanguage,
      ),
      uid,
    );

    // 3️⃣ Save PatientModel
    await _patientService.savePatient(
      PatientModel(patientId: uid),
      uid,
    );

    // 4️⃣ Navigate (normal navigation, not named)
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  } catch (e, st) {
    debugPrint('🔥 SignUp error: $e\n$st');

    final String errorMsg = e is FirebaseAuthException
        ? (e.message ?? e.code)
        : e.toString();

    Get.snackbar(
      'Sign Up Error',
      errorMsg,
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
          margin: EdgeInsets.only(top: 100.h),
          child: Column(
            children: [
              Text("Therapify", style: Theme.of(context).textTheme.titleLarge),
              const VSpace(10),
              const Text("Enter your details to create an account!"),
              const VSpace(50),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Full Name
                    const Text("Full Name"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _nameCtrl,
                      validator: (v) => (v?.isEmpty ?? true) ? 'Enter name' : null,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Full Name',
                      ),
                    ),

                    // Email
                    const VSpace(20),
                    const Text("Email Address"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _emailCtrl,
                      validator: (v) {
                        if (v?.isEmpty ?? true) return 'Enter email';
                        final re = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                        return re.hasMatch(v!) ? null : 'Invalid email';
                      },
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Email Address',
                      ),
                    ),

                    // Phone
                    const VSpace(20),
                    const Text("Phone Number"),
                    VSpace(8.h),
                    Row(
                      children: [
                        Container(
                          width: 130.w,
                          height: 52.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.getBorderColor()),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: CountryCodePicker(
                            onChanged: (cc) {
                              phoneCode      = cc.dialCode ?? phoneCode;
                              initialCountry = cc.code ?? initialCountry;
                            },
                            initialSelection: initialCountry,
                            boxDecoration: BoxDecoration(
                              color: AppColors.getContainerColor(),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: Utils.defaultBoxShadow(),
                            ),
                          ),
                        ),
                        const HSpace(10),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneCtrl,
                            keyboardType: TextInputType.number,
                            validator: (v) => (v?.isEmpty ?? true) ? 'Enter phone' : null,
                            decoration: AppInputDecoration.roundInputDecoration(
                              context: context,
                              hintText: 'Phone',
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Gender
                    const VSpace(20),
                    const Text("Gender"),
                    VSpace(8.h),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Select Gender',
                      ),
                      items: _genders
                          .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedGender = val);
                      },
                    ),

                    // Language
                    const VSpace(20),
                    const Text("Preferred Language"),
                    VSpace(8.h),
                    DropdownButtonFormField<String>(
                      value: _selectedLanguage,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Select Language',
                      ),
                      items: _languages
                          .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedLanguage = val);
                      },
                    ),

                    // Password
                    const VSpace(20),
                    const Text("Password"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: _obscurePassword,
                      validator: (v) => (v?.isEmpty ?? true) ? 'Enter password' : null,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Ionicons.eye_off_outline
                              : Ionicons.eye_outline),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                    ),

                    // Confirm Password
                    const VSpace(20),
                    const Text("Confirm Password"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _confirmCtrl,
                      obscureText: _obscurePassword,
                      validator: (v) {
                        if ((v?.isEmpty ?? true)) return 'Confirm password';
                        if (v != _passwordCtrl.text) return 'Passwords do not match';
                        return null;
                      },
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Ionicons.eye_off_outline
                              : Ionicons.eye_outline),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                    ),

                    // Sign Up Button
                    const VSpace(25),
                    AppButton(
                      title: "Sign Up".tr,
                      height: 50.h,
                      onPress: _onSignUpPressed,
                      bgColor: Colors.blue,
                    ),
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
