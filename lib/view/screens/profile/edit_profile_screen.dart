import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:therapify/view/widgets/dropdown_button.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AppController appController = Get.find<AppController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String initialCountry = 'RU';
  String phoneCode = '+7';
  final List<dynamic> _languages = [
    {"name": 'English', "rtl": false},
    {"name": 'Spanish', "rtl": true},
    {"name": "Arabic", "rtl": true},
  ];
  final List<String> _bloodGroups = ['A', "A+", "A-", "B", "B+", "B-", 'O', 'O+', 'O-', 'AB', 'AB+', 'AB-'];
  final List<String> _genders = ['Male', "Female"];
  String? _selectedLanguage;
  String? _selectedGender;
  String? _selectedBloodGroup;

  File? _pickedUserImage;
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedUserImage = File(pickedFile.path);
      });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: _pickedUserImage == null
                        ? Image.asset(
                            "assets/images/user.png",
                            width: 100.r,
                            height: 100.r,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            _pickedUserImage!,
                            width: 100.r,
                            height: 100.r,
                            fit: BoxFit.cover,
                          ),
                  ),
                  HSpace(20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Adam Levine",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      VSpace(10.h),
                      Text("hellojohnjgrubs@gmail.com", style: Theme.of(context).textTheme.bodySmall),
                      VSpace(10.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration:
                            BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(35.w)),
                        child: InkWell(
                          onTap: _pickImage,
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.image_sharp,
                                color: AppColors.whiteColor,
                                size: 16.sp,
                              ),
                              HSpace(5.w),
                              Text(
                                "Upload Image",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                        fit: BoxFit.contain)),
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
              TextFormField(
                controller: _firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: 'First Name',
                  fillColor: AppColors.getContainerColor(),
                  borderColor: AppColors.getContainerColor(),
                  prefixIcon: Image.asset("assets/icons/person.png", color: AppColors.getTextColor()),
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: 'Last Name',
                  fillColor: AppColors.getContainerColor(),
                  borderColor: AppColors.getContainerColor(),
                  prefixIcon: Image.asset("assets/icons/person.png", color: AppColors.getTextColor()),
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: 'Username',
                  fillColor: AppColors.getContainerColor(),
                  borderColor: AppColors.getContainerColor(),
                  prefixIcon: Image.asset("assets/icons/at.png", color: AppColors.getTextColor()),
                ),
              ),
              SizedBox(height: 20.h),
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
                  prefixIcon: Image.asset("assets/icons/mail.png", color: AppColors.getTextColor()),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: SearchableDropdown(
                      dropdownItems: _genders.asMap().map((index, gender) => MapEntry(index, gender)).values.toList(),
                      selectedItem: _selectedGender,
                      prefixIcon: Image.asset("assets/icons/gender.png", color: AppColors.getTextColor()),
                      hintText: "Gender",
                      onChanged: (String? value) {
                        if (value != null) {
                          _selectedGender = value;
                        }
                      },
                    ),
                  ),
                  HSpace(10.w),
                  Expanded(
                    child: SearchableDropdown(
                      dropdownItems:
                          _bloodGroups.asMap().map((index, gender) => MapEntry(index, gender)).values.toList(),
                      selectedItem: _selectedBloodGroup,
                      prefixIcon: Image.asset("assets/icons/blood_drop.png", color: AppColors.getTextColor()),
                      hintText: "Blood Group",
                      onChanged: (String? value) {
                        if (value != null) {
                          _selectedBloodGroup = value;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(10.r)),
                    width: 130.w,
                    height: 50.h,
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
                        fillColor: AppColors.getContainerColor(),
                        borderColor: AppColors.getContainerColor(),
                        prefixIcon: Image.asset("assets/icons/phone.png", color: AppColors.getTextColor()),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _countryController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter country';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: 'Country',
                  fillColor: AppColors.getContainerColor(),
                  borderColor: AppColors.getContainerColor(),
                  prefixIcon: Image.asset("assets/icons/flag.png", color: AppColors.getTextColor()),
                ),
              ),
              SizedBox(height: 20.h),
              SearchableDropdown(
                dropdownItems: _languages.map((language) => language['name']!).toList(),
                selectedItem: _selectedLanguage,
                prefixIcon: Image.asset("assets/icons/language.png", color: AppColors.getTextColor()),
                hintText: "Select Language",
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _selectedLanguage = value;
                      final selectedLanguage = _languages.firstWhere((language) => language['name'] == value);
                      appController.setTextDirection(selectedLanguage['rtl'] as bool);
                    });
                  }
                },
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _addressController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: 'Address',
                  fillColor: AppColors.getContainerColor(),
                  borderColor: AppColors.getContainerColor(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 25.h),
              Center(
                child: AppButton(
                  title: "Save Changes".tr,
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
