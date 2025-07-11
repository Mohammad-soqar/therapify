import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/screens/appointment/appointment_countdown_screen.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/section_header_with_line.dart';
import 'package:therapify/view/widgets/spacing.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  State<AppointmentDetailsScreen> createState() => _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  late Map<String, dynamic> appointment;

  @override
  void initState() {
    super.initState();
    appointment = widget.appointment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.getContainerColor(),
          boxShadow: Utils.defaultBoxShadow(),
        ),
        child: AppButton(
          title: "Video Call (Start at ${appointment['appointmentTime'] ?? 'Unknown'})",
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AppointmentCountdownScreen()),
            );
          },
          bgColor: AppColors.primaryColor,
          icon: const Icon(Icons.videocam, color: AppColors.whiteColor),
        ),
      ),
      appBar: const CustomAppbar(
        leading: [GetBackButton()],
        title: "My Appointment",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info Card
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100.r,
                    height: 100.r,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withAlpha((0.3 * 255).toInt()),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.asset(
                        "assets/images/doctor/doctor_4.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  HSpace(15.w),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dr. ${appointment['doctorName'] ?? 'Unknown'}",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: AppColors.getTitleColor(),
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        VSpace(8.h),
                        Row(
                          children: [
                            Icon(CupertinoIcons.star_fill, color: AppColors.warningColor, size: 14.sp),
                            HSpace(5.w),
                            Text(
                              "${appointment['rating'] ?? '4.6'} (${appointment['reviews'] ?? '26'} reviews)",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.getTitleColor(),
                                  ),
                            ),
                          ],
                        ),
                        VSpace(8.h),
                        Text(
                          appointment['doctorSpecialization'] ?? 'Specialist',
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            VSpace(30.h),
            const SectionHeaderWithLine(title: "Visit Time"),
            VSpace(16.h),
            Text(appointment['appointmentDate'] ?? 'Unknown Date'),
            VSpace(8.h),
            Row(
              children: [
                Text(
                  "${appointment['appointmentTime'] ?? 'Unknown Time'}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                HSpace(10.w),
                Text("(Morning Slot)", style: Theme.of(context).textTheme.bodySmall),
              ],
            ),

            VSpace(30.h),
            const SectionHeaderWithLine(title: "Patient Information"),
            VSpace(16.h),
            Row(
              children: [
                Container(constraints: BoxConstraints(minWidth: 120.w), child: const Text("Full Name:")),
                Text(": ${appointment['patientName'] ?? ''}"),
              ],
            ),
            VSpace(8.h),
            Row(
              children: [
                Container(constraints: BoxConstraints(minWidth: 120.w), child: const Text("Gender:")),
                Text(": ${appointment['patientGender'] ?? 'Unknown'}"),
              ],
            ),

            VSpace(30.h),
            const SectionHeaderWithLine(title: "Fee Information"),
            VSpace(20.h),
            Container(
              margin: EdgeInsets.only(bottom: 15.h),
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 5.h),
                leading: Container(
                  width: 50.h,
                  height: 50.h,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Image.asset(
                    "assets/icons/video.png",
                    width: 24.w,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: Text("Video Call", style: Theme.of(context).textTheme.bodyLarge),
                ),
                subtitle: Text(
                  "Able to video chat with the doctor",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Column(
                  children: [
                    Text(
                      "\$${appointment['consultationFee'] ?? '20'}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.primaryColor),
                    ),
                    VSpace(8.h),
                    Text(
                      "Paid",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.successColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
