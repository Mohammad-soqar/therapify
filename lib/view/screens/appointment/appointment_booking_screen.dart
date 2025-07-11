import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/bottom_sheet.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:therapify/viewmodels/controllers/ticket_controller.dart';

class AppointmentBookingScreen extends StatefulWidget {
  final DoctorModel doctor;

  const AppointmentBookingScreen({super.key, required this.doctor});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  final AppController appController = Get.find<AppController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late DoctorModel doctor;
  dynamic _selectedDate;
  dynamic _selectedTimeSlot;
  String? patientId;

  @override
  void initState() {
    super.initState();
    doctor = widget.doctor;

    if (doctor.schedule.isNotEmpty) {
      _selectedDate = doctor.schedule[0];
      if (_selectedDate.timeSlots.isNotEmpty) {
        _selectedTimeSlot = _selectedDate.timeSlots[0];
      }
    }
    patientId = _auth.currentUser?.uid;

  }

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
                    itemCount: doctor.schedule.length,
                    separatorBuilder: (context, index) => SizedBox(width: 15.w),
                    itemBuilder: (context, index) {
                      final item = doctor.schedule[index];
                      return InkWell(
                        onTap: () {
                          _selectedDate = item;
                          _selectedTimeSlot = item.timeSlots.isNotEmpty
                              ? item.timeSlots[0]
                              : null;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: _selectedDate == item
                                ? AppColors.primaryColor
                                : AppColors.getContainerColor(),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.getBackgroundColor(),
                                child: Text(
                                  item.day.substring(0, 3),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ),
                              VSpace(8.h),
                              Text(
                                item.date.substring(8, 10),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 14.sp,
                                      color: _selectedDate == item
                                          ? AppColors.whiteColor
                                          : AppColors.getTextColor(),
                                    ),
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
                  child: _selectedDate?.timeSlots.isNotEmpty ?? false
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedDate.timeSlots.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 15.w),
                          itemBuilder: (context, index) {
                            final item = _selectedDate.timeSlots[index];
                            return InkWell(
                              onTap: () {
                                _selectedTimeSlot = item;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: _selectedTimeSlot == item
                                      ? AppColors.primaryColor
                                      : AppColors.getContainerColor(),
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: Text(
                                  item,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        color: _selectedTimeSlot == item
                                            ? AppColors.whiteColor
                                            : AppColors.getTextColor(),
                                      ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(child: Text("No available time slots")),
                ),
                VSpace(20.h),
                TextFormField(
                  controller: _messageController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter message' : null,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 4,
                  decoration: AppInputDecoration.roundInputDecoration(
                    context: context,
                    hintText: 'Explain your problem shortly',
                    borderColor: AppColors.getContainerColor(),
                    fillColor: AppColors.getContainerColor(),
                  ),
                ),
                VSpace(25.h),
                Center(
                  child: AppButton(
                    title: "Submit".tr,
                    height: 50.h,
                    width: double.infinity,
                    bgColor: AppColors.primaryColor,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        showCustomModalBottomSheet(
                          context,
                          doctor: doctor,
                          selectedDate: _selectedDate.date,
                          selectedTime: _selectedTimeSlot,
                          patientId: patientId!, // ✅ added this
                          description: _messageController.text.trim(), // ✅ added this
                        );
                      }
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
