import 'package:therapify/data/static/doctor_data.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:therapify/view/widgets/dropdown_button.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:therapify/viewmodels/controllers/ticket_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final AppointmentController appointmentController = Get.put(AppointmentController());
  final AppController appController = Get.find<AppController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String? _selectedGender;
  final List<String> _genders = ['Male', "Female"];
  dynamic _selectedDate = doctorData[0].schedule[0];
  dynamic _selectedTimeSlot = doctorData[0].schedule[0].timeSlots[0];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(builder: (ticketController) {
      return Scaffold(
        appBar: const CustomAppbar(
          title: "Appointment",
          leading: [GetBackButton()],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date", style: Theme.of(context).textTheme.titleMedium),
                VSpace(8.h),
                SizedBox(
                  height: 95.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: doctorData[0].schedule.length,
                    separatorBuilder: (context, index) => SizedBox(width: 15.w),
                    itemBuilder: (context, index) {
                      final item = doctorData[0].schedule[index];
                      return InkWell(
                        onTap: () {
                          _selectedDate = item;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: _selectedDate == item ? AppColors.primaryColor : AppColors.getContainerColor(),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.getBackgroundColor(),
                                child: Text(
                                  item.day.substring(0, 3),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                                ),
                              ),
                              VSpace(8.h),
                              Text(
                                item.date.substring(8, 10),
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.sp,
                                    color: _selectedDate == item ? AppColors.whiteColor : AppColors.getTextColor()),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                VSpace(20.h),
                Text("Time", style: Theme.of(context).textTheme.titleMedium),
                VSpace(8.h),
                SizedBox(
                  height: 40.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedDate.timeSlots.length,
                    separatorBuilder: (context, index) => SizedBox(width: 15.w),
                    itemBuilder: (context, index) {
                      final item = _selectedDate.timeSlots[index];
                      return InkWell(
                        onTap: () {
                          _selectedTimeSlot = item;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: _selectedTimeSlot == item ? AppColors.primaryColor : AppColors.getContainerColor(),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 14.sp,
                                color: _selectedTimeSlot == item ? AppColors.whiteColor : AppColors.getTextColor()),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                VSpace(20.h),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter subject';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: AppInputDecoration.roundInputDecoration(
                    context: context,
                    hintText: 'Patient Name',
                    borderColor: AppColors.getContainerColor(),
                    fillColor: AppColors.getContainerColor(),
                    prefixIcon: Image.asset("assets/icons/user.png", color: AppColors.getTextColor()),
                  ),
                ),
                SizedBox(height: 20.h),
                SearchableDropdown(
                  dropdownItems: _genders.asMap().map((index, language) => MapEntry(index, language)).values.toList(),
                  selectedItem: _selectedGender,
                  prefixIcon: Image.asset("assets/icons/gender.png", color: AppColors.getTextColor()),
                  hintText: "Gender",
                  onChanged: (String? value) {
                    if (value != null) {
                      _selectedGender = value;
                    }
                  },
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: AppInputDecoration.roundInputDecoration(
                    context: context,
                    hintText: 'Age',
                    borderColor: AppColors.getContainerColor(),
                    fillColor: AppColors.getContainerColor(),
                    prefixIcon: Image.asset("assets/icons/calendar.png", color: AppColors.getTextColor()),
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _weightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter weight';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: AppInputDecoration.roundInputDecoration(
                    context: context,
                    hintText: 'Weight (kg)',
                    borderColor: AppColors.getContainerColor(),
                    fillColor: AppColors.getContainerColor(),
                    prefixIcon: Image.asset("assets/icons/weight_scale.png", color: AppColors.getTextColor()),
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _messageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter message';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: AppInputDecoration.roundInputDecoration(
                    context: context,
                    hintText: 'Explain your problem shortly',
                    borderColor: AppColors.getContainerColor(),
                    fillColor: AppColors.getContainerColor(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 20.h),
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.getContainerColor(),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Attach reports and previous prescriptions (if any)",
                                style: Theme.of(context).textTheme.titleMedium),
                            VSpace(16.h),
                            Text("JPG, PNG, PDF (Max No. of attachments: 10)",
                                style: Theme.of(context).textTheme.bodySmall),
                            ticketController.selectedFiles.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.only(left: 0, right: 0, top: 20.h, bottom: 0),
                                    shrinkWrap: true,
                                    itemCount: ticketController.selectedFiles.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 40.h,
                                        margin: EdgeInsets.symmetric(vertical: 5.h),
                                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                                        decoration: BoxDecoration(
                                            color: AppColors.getCardColor(), borderRadius: BorderRadius.circular(8.r)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              ticketController.selectedFiles[index].path.split('/').last,
                                              style: Theme.of(context).textTheme.bodySmall,
                                              maxLines: 1,
                                            ),
                                            IconButton(
                                              onPressed: () => ticketController.removeFile(index),
                                              icon: Icon(
                                                CupertinoIcons.xmark,
                                                color: AppColors.getTextColor(),
                                                size: 16.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      Positioned(
                        right: appController.isRtl() ? null : -20,
                        left: appController.isRtl() ? -20 : null,
                        top: -20,
                        child: InkWell(
                          onTap: () {
                            ticketController.pickFiles();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 36.r,
                              right: appController.isRtl() ? 24.w : 36.w,
                              bottom: 24.h,
                              left: appController.isRtl() ? 36.w : 24.w,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(appController.isRtl() ? 0 : 50.r),
                                topRight: Radius.circular(appController.isRtl() ? 50.r : 0),
                                bottomLeft: Radius.circular(50.r),
                                bottomRight: Radius.circular(50.r),
                              ),
                            ),
                            child: Image.asset(
                              "assets/icons/upload.png",
                              width: 32.r,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Center(
                  child: AppButton(
                    title: "Submit".tr,
                    height: 50.h,
                    width: double.infinity,
                    bgColor: AppColors.primaryColor,
                    onPress: () {
                      Get.toNamed(RoutesName.paymentScreen);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
