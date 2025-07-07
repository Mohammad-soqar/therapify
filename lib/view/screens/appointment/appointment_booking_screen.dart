import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/payment/payment_screen.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/dropdown_button.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:therapify/viewmodels/controllers/ticket_controller.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  final AppController appController = Get.find<AppController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _selectedGender;
  final List<String> _genders = ['Male', "Female"];

  late DoctorModel doctor;
  dynamic _selectedDate;
  dynamic _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    doctor = Get.arguments as DoctorModel;

    if (doctor.schedule.isNotEmpty) {
      _selectedDate = doctor.schedule[0];
      if (_selectedDate.timeSlots.isNotEmpty) {
        _selectedTimeSlot = _selectedDate.timeSlots[0];
      }
    }
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
                // Date Picker
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
                                            : AppColors.getTextColor()),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Time Picker
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

                // Patient Info Form
                VSpace(20.h),
                TextFormField(
                  controller: _nameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter name' : null,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: AppInputDecoration.roundInputDecoration(
                    context: context,
                    hintText: 'Patient Name',
                    borderColor: AppColors.getContainerColor(),
                    fillColor: AppColors.getContainerColor(),
                    prefixIcon: Image.asset("assets/icons/user.png",
                        color: AppColors.getTextColor()),
                  ),
                ),

                VSpace(20.h),
                SearchableDropdown(
                  dropdownItems: _genders,
                  selectedItem: _selectedGender,
                  hintText: "Gender",
                  prefixIcon: Image.asset("assets/icons/gender.png",
                      color: AppColors.getTextColor()),
                  onChanged: (String? value) {
                    _selectedGender = value;
                  },
                ),

                VSpace(20.h),
                TextFormField(
                  controller: _ageController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter age' : null,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: AppInputDecoration.roundInputDecoration(
                    context: context,
                    hintText: 'Age',
                    borderColor: AppColors.getContainerColor(),
                    fillColor: AppColors.getContainerColor(),
                    prefixIcon: Image.asset("assets/icons/calendar.png",
                        color: AppColors.getTextColor()),
                  ),
                ),

                VSpace(20.h),
                TextFormField(
                  controller: _weightController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter weight' : null,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: AppInputDecoration.roundInputDecoration(
                    context: context,
                    hintText: 'Weight (kg)',
                    borderColor: AppColors.getContainerColor(),
                    fillColor: AppColors.getContainerColor(),
                    prefixIcon: Image.asset("assets/icons/weight_scale.png",
                        color: AppColors.getTextColor()),
                  ),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PaymentScreen()));
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
