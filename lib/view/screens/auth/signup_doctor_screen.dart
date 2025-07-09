// lib/view/screens/auth/doctor_sign_up_screen.dart

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/data/models/user.dart';
import 'package:therapify/data/services/doctor_service.dart';
import 'package:therapify/data/services/user_service.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/screens/doctor_dashboard/doctor_dashboard_view.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';

class DoctorSignUpScreen extends StatefulWidget {
  static const String routeName = "/signUpDoctor";
  const DoctorSignUpScreen({super.key});

  @override
  State<DoctorSignUpScreen> createState() => _DoctorSignUpScreenState();
}

class _DoctorSignUpScreenState extends State<DoctorSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // User fields
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  String initialCountry = 'TR';
  String phoneCode = '+90';

  // Doctor fields
  final _categoryCtrl = TextEditingController();
  final _consultFeeCtrl = TextEditingController();
  final _netFeeCtrl = TextEditingController();
  bool _allowsFollowUp = false;
  DateTime? _availDate;
  TimeOfDay? _availTime;
  final _locationCtrl = TextEditingController();

  bool _obscurePassword = true;

  final _userService = UserService();
  final _doctorService = DoctorService();

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) setState(() => _availDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) setState(() => _availTime = picked);
  }

  Future<void> _onSignUpPressed() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    if (_availDate == null || _availTime == null) {
      Get.snackbar('Missing Info', 'Please pick availability date & time',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      // 1️⃣ Firebase Auth
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );
      final uid = cred.user?.uid;
      if (uid == null)
        throw FirebaseAuthException(
            code: 'NO_USER', message: 'Failed to create account.');

      // 2️⃣ Save user profile
      await _userService.saveUser(
        UserModel(
          name: _nameCtrl.text.trim(),
          dob: DateTime.now(),
          phoneNumber: _phoneCtrl.text.trim(),
          role: 'doctor',
          gender: '',
          email: _emailCtrl.text.trim(),
          country: '',
          language: '',
        ),
        uid,
      );

      // 3️⃣ Save doctor profile
      final dateStr = "${_availDate!.year.toString().padLeft(4, '0')}"
          "-${_availDate!.month.toString().padLeft(2, '0')}"
          "-${_availDate!.day.toString().padLeft(2, '0')}";
      final timeStr = "${_availTime!.hour.toString().padLeft(2, '0')}"
          ":${_availTime!.minute.toString().padLeft(2, '0')}";

      await _doctorService.saveDoctor(
        DoctorModel(
          doctorId: uid,
          name: _nameCtrl.text.trim(),
          category: _categoryCtrl.text.trim(),
          consultationFee: double.parse(_consultFeeCtrl.text.trim()),
          netConsultationFee: double.parse(_netFeeCtrl.text.trim()),
          followUp: double.parse(_netFeeCtrl.text.trim()),
          availabilityDate: dateStr,
          availabilityTime: timeStr,
          location: _locationCtrl.text.trim(),
          phoneNumber: "${phoneCode}${_phoneCtrl.text.trim()}",
          workplace: "",
          bio: "",
          workingIn: "",
          averageConsultationTime: 15, // Default value, can be adjusted later
          rating: 0.0, // ✅ fixed
          imageUrl: "",
          specialization: _categoryCtrl.text.trim(),
          schedule: [],
        ),
        uid,
      );

      // 4️⃣ Go to dashboard
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DoctorDashboardView()),
      );
    } catch (e) {
      final msg =
          e is FirebaseAuthException ? (e.message ?? e.code) : e.toString();
      Get.snackbar('Sign Up Failed', msg, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Sign Up')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 16.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- User Info ---
              const Text("Full Name"),
              VSpace(8.h),
              TextFormField(
                controller: _nameCtrl,
                validator: (v) => (v?.isEmpty ?? true) ? 'Enter name' : null,
                decoration: AppInputDecoration.roundInputDecoration(
                    context: context, hintText: 'Full Name'),
              ),
              VSpace(16.h),

              const Text("Email Address"),
              VSpace(8.h),
              TextFormField(
                controller: _emailCtrl,
                validator: (v) {
                  if (v?.isEmpty ?? true) return 'Enter email';
                  final re =
                      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                  return re.hasMatch(v!) ? null : 'Invalid email';
                },
                decoration: AppInputDecoration.roundInputDecoration(
                    context: context, hintText: 'Email'),
              ),
              VSpace(16.h),

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
                        phoneCode = cc.dialCode ?? phoneCode;
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
                      validator: (v) =>
                          (v?.isEmpty ?? true) ? 'Enter phone' : null,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Phone',
                      ),
                    ),
                  ),
                ],
              ),
              VSpace(16.h),

              const Text("Password"),
              VSpace(8.h),
              TextFormField(
                controller: _passwordCtrl,
                obscureText: _obscurePassword,
                validator: (v) =>
                    (v?.isEmpty ?? true) ? 'Enter password' : null,
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
              VSpace(16.h),

              const Text("Confirm Password"),
              VSpace(8.h),
              TextFormField(
                controller: _confirmCtrl,
                obscureText: _obscurePassword,
                validator: (v) {
                  if (v?.isEmpty ?? true) return 'Confirm password';
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
              VSpace(32.h),

              // --- Doctor Details ---
              const Text("Category / Specialty"),
              VSpace(8.h),
              TextFormField(
                controller: _categoryCtrl,
                validator: (v) =>
                    (v?.isEmpty ?? true) ? 'Enter category' : null,
                decoration: AppInputDecoration.roundInputDecoration(
                    context: context, hintText: 'e.g. Cardiology'),
              ),
              VSpace(16.h),

              Row(children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Consultation Fee"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _consultFeeCtrl,
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          (v?.isEmpty ?? true) ? 'Enter fee' : null,
                      decoration: AppInputDecoration.roundInputDecoration(
                          context: context, hintText: 'e.g. 50.0'),
                    ),
                  ],
                )),
                HSpace(16.w),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Net Fee"),
                    VSpace(8.h),
                    TextFormField(
                      controller: _netFeeCtrl,
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          (v?.isEmpty ?? true) ? 'Enter net fee' : null,
                      decoration: AppInputDecoration.roundInputDecoration(
                          context: context, hintText: 'e.g. 45.0'),
                    ),
                  ],
                )),
              ]),
              VSpace(16.h),

              Row(
                children: [
                  Switch(
                    value: _allowsFollowUp,
                    onChanged: (v) => setState(() => _allowsFollowUp = v),
                  ),
                  const Text("Allow follow-up appointments")
                ],
              ),
              VSpace(16.h),

              Row(children: [
                Expanded(
                  child: AppButton(
                    title: _availDate == null
                        ? "Pick Date"
                        : _availDate!
                            .toLocal()
                            .toIso8601String()
                            .split('T')
                            .first,
                    height: 44.h,
                    onPress: _pickDate,
                    bgColor: Colors.blue,
                  ),
                ),
                HSpace(16.w),
                Expanded(
                  child: AppButton(
                    title: _availTime == null
                        ? "Pick Time"
                        : _availTime!.format(context),
                    height: 44.h,
                    onPress: _pickTime,
                    bgColor: Colors.blue,
                  ),
                ),
              ]),
              VSpace(16.h),

              const Text("Location"),
              VSpace(8.h),
              TextFormField(
                controller: _locationCtrl,
                validator: (v) =>
                    (v?.isEmpty ?? true) ? 'Enter location' : null,
                decoration: AppInputDecoration.roundInputDecoration(
                    context: context, hintText: 'e.g. Istanbul'),
              ),
              VSpace(32.h),

              // --- Submit ---
              AppButton(
                title: "Register as Doctor",
                onPress: _onSignUpPressed,
                bgColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
