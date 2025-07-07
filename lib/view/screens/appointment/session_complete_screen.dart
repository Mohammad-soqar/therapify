import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/doctor/doctor_review_screen.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/bottom_nav.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SessionCompleteScreen extends StatefulWidget {
  const SessionCompleteScreen({super.key});

  @override
  State<SessionCompleteScreen> createState() => _SessionCompleteScreenState();
}

class _SessionCompleteScreenState extends State<SessionCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Session Complete",
        leading: [GetBackButton()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  VSpace(20.h),
                  SizedBox(width: 180.w, height: 180.w, child: Image.asset("assets/images/complete_session.png")),
                  VSpace(10.h),
                  Text("The consultation session finished.", style: Theme.of(context).textTheme.titleMedium),
                  VSpace(10.h),
                  const Text(
                    "Recording have been saved in activity history.",
                    textAlign: TextAlign.center,
                  ),
                  VSpace(50.h), // Add some spacing if needed
                  DottedLine(
                    dashLength: 10.0,
                    dashGapLength: 10.0,
                    lineThickness: 1.0,
                    dashColor: AppColors.getBorderColor(),
                  ),
                  VSpace(50.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80.r,
                          height: 80.r,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withAlpha((0.3 * 255).toInt()),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: Image.asset(
                              "assets/images/doctor/doctor_4.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        HSpace(15.w),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr. Roland L. Jessen",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.getTitleColor()),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  VSpace(8.h),
                                  Row(
                                    children: [
                                      Icon(CupertinoIcons.star_fill, color: AppColors.warningColor, size: 14.sp),
                                      HSpace(5.w),
                                      Text(
                                        "4.6 (26 reviews)",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 14.sp, color: AppColors.getTitleColor()),
                                      ),
                                    ],
                                  ),
                                  VSpace(8.h),
                                  Text(
                                    "Allergist/Immunologist",
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
                  ),
                ],
              ),
            ),
            VSpace(50.h), // Add some spacing if needed
            DottedLine(
              dashLength: 10.0,
              dashGapLength: 10.0,
              lineThickness: 1.0,
              dashColor: AppColors.getBorderColor(),
            ),
            VSpace(50.h),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: "Return Home",
                    onPress: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BottomNavbar(),
                        ),
                      );
                    },
                    bgColor: AppColors.getContainerColor(),
                    borderColor: AppColors.primaryColor.withAlpha((0.2 * 255).toInt()),
                    width: double.infinity,
                    textColor: AppColors.getTitleColor(),
                  ),
                ),
                HSpace(15.w),
                Expanded(
                  child: AppButton(
                    title: "Write a review",
                    onPress: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DoctorReviewScreen(),
                        ),
                      );
                    },
                    bgColor: AppColors.primaryColor,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
