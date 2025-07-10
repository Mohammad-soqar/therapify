import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AppController appController = Get.find<AppController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String initialCountry = 'TR';
  String phoneCode = '+90';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          _fullNameController.text = data['name'] ?? '';
          _emailController.text = data['email'] ?? '';
          _phoneNumberController.text = data['phoneNumber'] ?? '';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Edit Profile",
        leading: [GetBackButton()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(20.h),
              Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/icons/heading_line.png'),
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcATop,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    "Edit Info",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Full Name
              TextFormField(
                controller: _fullNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Full name';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: 'Full Name',
                  fillColor: AppColors.getContainerColor(),
                  borderColor: AppColors.getContainerColor(),
                  prefixIcon: Image.asset("assets/icons/person.png",
                      color: AppColors.getTextColor()),
                ),
              ),
              SizedBox(height: 20.h),

              // Email Address
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
                  fillColor: AppColors.getContainerColor(),
                  borderColor: AppColors.getContainerColor(),
                  prefixIcon: Image.asset("assets/icons/mail.png",
                      color: AppColors.getTextColor()),
                ),
              ),
              SizedBox(height: 20.h),

              // Phone Number
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.getContainerColor(),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    width: 130.w,
                    height: 50.h,
                    child: CountryCodePicker(
                      onChanged: (countryCode) {
                        phoneCode = countryCode.dialCode.toString();
                        initialCountry = countryCode.code.toString();
                      },
                      initialSelection: initialCountry,
                      favorite: const ['+90', 'TR'],
                      alignLeft: true,
                      boxDecoration: BoxDecoration(
                        color: AppColors.getContainerColor(),
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: Utils.defaultBoxShadow(),
                      ),
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      searchStyle: Theme.of(context).textTheme.bodyMedium,
                      dialogTextStyle: Theme.of(context).textTheme.bodyMedium,
                      closeIcon: Icon(Ionicons.close_outline,
                          size: 22.sp, color: AppColors.getTextColor()),
                      searchDecoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Search',
                        prefixIcon: Image.asset(
                          "assets/icons/search.png",
                          color: AppColors.getTextColor2(),
                        ),
                        fillColor: AppColors.getContainerColor(),
                        borderColor: AppColors.getBorderColor(),
                      ),
                    ),
                  ),
                  const HSpace(10),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field can not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Phone',
                        fillColor: AppColors.getContainerColor(),
                        borderColor: AppColors.getContainerColor(),
                        prefixIcon: Image.asset("assets/icons/phone.png",
                            color: AppColors.getTextColor()),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),

              // Save Button
              Center(
                child: AppButton(
                  title: "Save Changes".tr,
                  height: 50.h,
                  width: double.infinity,
                  bgColor: AppColors.primaryColor,
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      final user = FirebaseAuth.instance.currentUser;
                      final newEmail = _emailController.text.trim();
                      final newName = _fullNameController.text.trim();
                      final newPhone = _phoneNumberController.text.trim();

                      try {
                        // Update Firebase Auth email if it changed
                        if (user != null && user.email != newEmail) {
                          await user.updateEmail(newEmail);
                        }

                        // Update Firestore
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .update({
                          'name': newName,
                          'email': newEmail,
                          'phoneNumber': newPhone,
                        });

                        Get.snackbar(
                          'Profile Updated',
                          'Your profile was successfully updated.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.primaryColor,
                          colorText: Colors.white,
                        );
                      } catch (e) {
                        Get.snackbar(
                          'Update Failed',
                          e.toString(),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
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
