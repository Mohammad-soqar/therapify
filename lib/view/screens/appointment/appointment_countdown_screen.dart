import 'package:therapify/view/screens/appointment/session_complete_screen.dart';
import 'package:therapify/view/screens/call/call_screen.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AppointmentCountdownScreen extends StatefulWidget {
  const AppointmentCountdownScreen({super.key});

  @override
  State<AppointmentCountdownScreen> createState() => _AppointmentCountdownScreen();
}

class _AppointmentCountdownScreen extends State<AppointmentCountdownScreen> with SingleTickerProviderStateMixin {
  int counter = 12;

  initCounter() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        counter--;
        if (counter > 0) {
          initCounter();
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const CallScreen(),
            ),
          );
        }
      });
    });
  }

  @override
  initState() {
    super.initState();
    initCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        leading: [GetBackButton()],
        title: "Connecting with doctor",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr. Roland L. Jessen",
                              style:
                                  Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.getTitleColor()),
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
            VSpace(30.h),
            SizedBox(
              width: double.infinity,
              height: 600.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Please don’t closed the app",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Approximate time"),
                        VSpace(20.h),
                        Text(
                          "${counter.toString()} secs",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "The Doctor will call you soon. Please wait for few minutes. Your Serial number is 06",
                    textAlign: TextAlign.center,
                  ),
                  VSpace(20.h),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SessionCompleteScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.dangerColor.withAlpha((0.1 * 255).toInt()),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        children: [
                          const Icon(Ionicons.information_circle, color: AppColors.dangerColor),
                          HSpace(5.w),
                          const Flexible(
                            child: Text(
                              "Please stay quiet and keep the internet on",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
