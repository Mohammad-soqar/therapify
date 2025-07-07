import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentPreviewScreen extends StatefulWidget {
  const PaymentPreviewScreen({super.key});

  @override
  State<PaymentPreviewScreen> createState() => _PaymentPreviewScreenState();
}

class _PaymentPreviewScreenState extends State<PaymentPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Payment Details",
        leading: [GetBackButton()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
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
                        "assets/images/doctor/doctor_5.png",
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
            Container(
              padding: EdgeInsets.all(20.r),
              decoration:
                  BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Details", style: Theme.of(context).textTheme.titleMedium),
                  VSpace(10.h),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Consultation Fee"), Text(r"$20")],
                  ),
                  VSpace(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("VAT (7%)"),
                      Text(
                        r"$1.4",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.dangerColor),
                      )
                    ],
                  ),
                  VSpace(10.h),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Platform Fee"), Text(r"$0.5")],
                  ),
                  VSpace(10.h),
                  DottedLine(
                    dashLength: 5.0,
                    dashGapLength: 5.0,
                    lineThickness: 1.0,
                    dashColor: AppColors.getBorderColor(),
                  ),
                  VSpace(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Net Amount",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        r"$21.90",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ],
              ),
            ),
            VSpace(25.h),
            AppButton(
              title: "Payment Now",
              onPress: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaymentPreviewScreen(),
                        ),
                      );
                    },
              bgColor: AppColors.primaryColor,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
