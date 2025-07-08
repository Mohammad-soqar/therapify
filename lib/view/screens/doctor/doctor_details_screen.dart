import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/screens/appointment/appointment_booking_screen.dart';
import 'package:therapify/view/screens/call/call_screen.dart';
import 'package:therapify/view/screens/doctor/doctor_info_tab.dart';
import 'package:therapify/view/screens/doctor/doctor_review_tab.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:therapify/utils/whatsapp_launcher.dart';


class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreen();
}

class _DoctorDetailsScreen extends State<DoctorDetailsScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<dynamic> _tabButtons = ["Info", "Reviews"];

  @override
  Widget build(BuildContext context) {
    final DoctorModel item = Get.arguments as DoctorModel;

    final List<Widget> _tabs = [
      const DoctorInfoTab(),
      const DoctorReviewsTab(),
    ];

    return Scaffold(
      bottomNavigationBar: Container(
  padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 12.h),
  decoration: BoxDecoration(
    color: AppColors.getContainerColor(),
    boxShadow: Utils.defaultBoxShadow(),
  ),
  child: Row(
    children: [
      // Book Appointment Button
      Expanded(
        child: AppButton(
          title: "Book Appointment",
          onPress: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const AppointmentBookingScreen(),
              ),
            );
          },
          bgColor: AppColors.getContainerColor(),
          borderColor: AppColors.primaryColor,
          textColor: AppColors.getTitleColor(),
        ),
      ),
      HSpace(10.h),

      // See Doctor Now (WhatsApp) Button
      Expanded(
        child: AppButton(
          title: "See Doctor Now",
          onPress: () {
            final phone = item.phoneNumber ?? '';
            openWhatsAppChat(
              phone,
              message: "Hello Dr. ${item.name}, I’d like to talk now.",
            );
          },
          bgColor: AppColors.successColor,
          icon: const Icon(Icons.videocam, color: AppColors.whiteColor),
        ),
      ),
    ],
  ),
),

      appBar: CustomAppbar(
        leading: const [GetBackButton()],
        title: "Specialist Details",
        action: [
          InkWell(
            onTap: () {},
            child: Container(
              width: 36.r,
              height: 36.r,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColors.getBorderColor()),
              ),
              child: Image.asset(
                "assets/icons/heart.png",
                width: 24.w,
                color: AppColors.getTitleColor(),
              ),
            ),
          ),
          HSpace(10.w),
          InkWell(
            onTap: () => Share.share('check out my website https://example.com'),
            child: Container(
              width: 36.r,
              height: 36.r,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColors.getBorderColor()),
              ),
              child: Image.asset(
                "assets/icons/share.png",
                width: 24.w,
                color: AppColors.getTitleColor(),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: SizedBox(
                        width: 100.r,
                        height: 100.r,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: Image.
                          asset(
                             "assets/images/doctor_placeholder.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.getContainerColor(), width: 3),
                            borderRadius: BorderRadius.circular(30.r)),
                        child: CircleAvatar(
                          backgroundColor: AppColors.successColor,
                          radius: 7.r,
                        ),
                      ),
                    )
                  ],
                ),
                HSpace(10.w),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name!,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.getTitleColor()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          VSpace(8.h),
                          Row(
                            children: [
                              Icon(CupertinoIcons.star_fill, color: AppColors.warningColor, size: 14.sp),
                              HSpace(5.w),
                              Text(
                                "${item.rating?.toStringAsFixed(1) ?? 'N/A'}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 14.sp, color: AppColors.getTitleColor()),
                              ),
                            ],
                          ),
                          VSpace(8.h),
                          Text(
                            item.category ?? "Unknown",
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            VSpace(20.h),
            Row(
              children: [
                RichText(
                  text: TextSpan(text: "Working in ", style: Theme.of(context).textTheme.bodyMedium),
                ),
                RichText(
                  text: TextSpan(text: "Dhaka Civil Surgeon Office", style: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            ),
            VSpace(10.h),
            Row(
              children: [
                RichText(
                  text: TextSpan(text: "Consultation Fee:  ", style: Theme.of(context).textTheme.bodyMedium),
                ),
                RichText(
                  text: TextSpan(
                      text: "\$20 (Inc. VAT)",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor)),
                ),
              ],
            ),
            VSpace(20.h),
            Container(
              height: 56.h,
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(6.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _tabButtons.asMap().entries.map((entry) {
                  int index = entry.key;
                  String label = entry.value;
                  bool isActive = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: 110.w,
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.getBackgroundColor() : Colors.transparent,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        label,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: isActive ? AppColors.getTitleColor() : AppColors.getTextColor()),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            VSpace(20.h),
            _tabs[_selectedIndex],
          ],
        ),
      ),
    );
  }
}
