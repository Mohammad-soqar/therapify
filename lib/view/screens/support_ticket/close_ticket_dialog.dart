import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/spacing.dart';

class CloseTicketDialog extends StatelessWidget {
  const CloseTicketDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      titlePadding: EdgeInsets.all(0.w),
      backgroundColor: AppColors.getBackgroundColor(),
      surfaceTintColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          RichText(
            text: TextSpan(
              text: "Are you closing?",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              text: "Do you want to close the ticket?",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  width: 150.w,
                  height: 45.h,
                  title: "Cancel",
                  bgColor: AppColors.getContainerColor(),
                  textColor: AppColors.getTextColor(),
                  onPress: () {
                    Get.back();
                  },
                ),
              ),
              const HSpace(10),
              Expanded(
                child: AppButton(
                  width: 150.w,
                  height: 45.h,
                  title: "Close Ticket",
                  bgColor: AppColors.primaryColor,
                  onPress: () {
                    Get.offNamed(RoutesName.ticketScreen);
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return const CustomAlertDialog(
                    //         title: 'Ticket Closed',
                    //         message: 'You have successfully close the ticket.',
                    //         image: "assets/icons/success.json");
                    //   },
                    // );
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
