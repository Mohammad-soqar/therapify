import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.title, required this.message, required this.image});
  final String title;
  final String message;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.h),
            padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 25.h, top: 40.h),
            decoration: BoxDecoration(
              color: AppColors.getBackgroundColor(),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                RichText(
                  text: TextSpan(
                    text: title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                RichText(
                  text: TextSpan(
                    text: "\$16,000",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(text: "Amount", style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    RichText(
                      text: TextSpan(text: "16,000 USD", style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ],
                ),
                Divider(
                  height: 30.h,
                  color: AppColors.getBorderColor(),
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(text: "Charge", style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "1.75 USD",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.dangerColor)),
                    ),
                  ],
                ),
                Divider(
                  height: 30.h,
                  color: AppColors.getBorderColor(),
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(text: "Gateway", style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    RichText(
                      text: TextSpan(text: "Paytm", style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ],
                ),
                Divider(
                  height: 30.h,
                  color: AppColors.getBorderColor(),
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(text: "Date", style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    RichText(
                      text: TextSpan(text: "Nov 24, 2024", style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.h,
            child: Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.getBorderColor()),
                borderRadius: BorderRadius.circular(100.r),
                color: AppColors.getBackgroundColor(),
              ),
              width: 90.w,
              height: 90.w,
              child: Image.asset("assets/icons/thumbs_up.png"),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  //     titlePadding: EdgeInsets.all(0.w),
  //     backgroundColor: AppColors.getBackgroundColor(),
  //     surfaceTintColor: Colors.transparent,
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         SizedBox(height: 10.h),
  //         SizedBox(
  //           width: 500.w,
  //           child: Container(
  //             decoration: BoxDecoration(
  //               border: Border.all(color: AppColors.getBorderColor()),
  //               borderRadius: BorderRadius.circular(100.r),
  //             ),
  //             width: 40.w,
  //             height: 40.w,
  //             child: Image.asset("assets/icons/thumbs_up.png"),
  //           ),
  //         ),
  //         SizedBox(height: 15.h),
  //         RichText(
  //           text: TextSpan(
  //             text: title,
  //             style: Theme.of(context).textTheme.titleMedium,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //         SizedBox(height: 10.h),
  //         RichText(
  //           text: TextSpan(
  //             text: "\$16,000",
  //             style: Theme.of(context).textTheme.titleLarge,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //         // RichText(
  //         //   text: TextSpan(
  //         //     text: message,
  //         //     style: Theme.of(context).textTheme.bodyMedium,
  //         //   ),
  //         //   textAlign: TextAlign.center,
  //         // ),
  //         SizedBox(height: 20.h),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             RichText(
  //               text: TextSpan(text: "Amount", style: Theme.of(context).textTheme.bodyMedium),
  //             ),
  //             RichText(
  //               text: TextSpan(text: "16,000 USD", style: Theme.of(context).textTheme.bodyLarge),
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           height: 30.h,
  //           color: AppColors.getBorderColor(),
  //           thickness: 1,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             RichText(
  //               text: TextSpan(text: "Charge", style: Theme.of(context).textTheme.bodyMedium),
  //             ),
  //             RichText(
  //               text: TextSpan(
  //                   text: "1.75 USD",
  //                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.dangerColor)),
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           height: 30.h,
  //           color: AppColors.getBorderColor(),
  //           thickness: 1,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             RichText(
  //               text: TextSpan(text: "Gateway", style: Theme.of(context).textTheme.bodyMedium),
  //             ),
  //             RichText(
  //               text: TextSpan(text: "Paytm", style: Theme.of(context).textTheme.bodyLarge),
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           height: 30.h,
  //           color: AppColors.getBorderColor(),
  //           thickness: 1,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             RichText(
  //               text: TextSpan(text: "Date", style: Theme.of(context).textTheme.bodyMedium),
  //             ),
  //             RichText(
  //               text: TextSpan(text: "Nov 24, 2024", style: Theme.of(context).textTheme.bodyLarge),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
