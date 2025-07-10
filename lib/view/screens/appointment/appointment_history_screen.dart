import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/screens/doctor/doctor_review_screen.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/section_header_with_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class AppointmentHistoryScreen extends StatefulWidget {
  const AppointmentHistoryScreen({super.key});

  @override
  State<AppointmentHistoryScreen> createState() => _AppointmentHistoryScreen();
}

class _AppointmentHistoryScreen extends State<AppointmentHistoryScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        leading: [GetBackButton()],
        title: "Consultation History",
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
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Image.asset(
                    "assets/icons/rating.png",
                    color: AppColors.primaryColor,
                  ),
                ),
                title: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    "How was the experience?",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                subtitle: InkWell(
                  onTap: () {  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const DoctorReviewScreen()));},
                  child: Text(
                    "Make review",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
            VSpace(30.h),
            const SectionHeaderWithLine(title: "Patient Information"),
            VSpace(16.h),
            Row(
              children: [
                Container(constraints: BoxConstraints(minWidth: 120.w), child: const Text("Full Name:")),
                const Text(": John J. Grubs"),
              ],
            ),
            VSpace(8.h),
            Row(
              children: [
                Container(constraints: BoxConstraints(minWidth: 120.w), child: const Text("Gender:")),
                const Text(": Male"),
              ],
            ),
            VSpace(8.h),
            Row(
              children: [
                Container(constraints: BoxConstraints(minWidth: 120.w), child: const Text("Age:")),
                const Text(": 24"),
              ],
            ),
            VSpace(8.h),
            Row(
              children: [
                Container(constraints: BoxConstraints(minWidth: 120.w), child: const Text("Weight:")),
                const Text(": 75kg"),
              ],
            ),
            VSpace(30.h),
            const SectionHeaderWithLine(title: "Prescription"),
            VSpace(20.h),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        "assets/images/prescription.jpg",
                        width: 100.r,
                        height: 100.r,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 100.r,
                      height: 100.r,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha((0.2 * 255).toInt()),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 30,
                  bottom: 30,
                  left: 30,
                  right: 30,
                  child: Container(
                    width: 36.r,
                    height: 36.r,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(5.w)),
                    child: InkWell(
                      onTap: () async {
                        // Replace with the actual file path
                        String filePath = "assets/images/prescription.jpg";
                        final result = await OpenFile.open(filePath);
                        if (result.type != ResultType.done) {
                          Utils.toastMessage("Error opening file: ${result.message}", bgColor: AppColors.dangerColor);
                        }
                      },
                      child: Image.asset("assets/icons/zoom.png", color: AppColors.whiteColor),
                    ),
                  ),
                )
              ],
            ),
            VSpace(30.h),
            Container(
              padding: EdgeInsets.all(20.r),
              decoration:
                  BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Consultation Id",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          VSpace(8.h),
                          Text(
                            "245638",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                          ),
                          VSpace(20.h),
                          Text(
                            "Date",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          VSpace(8.h),
                          Text(
                            "20 July, 2024",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                          ),
                          VSpace(20.h),
                          Text(
                            "Fee",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          VSpace(8.h),
                          Text(
                            "\$20",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Invoice",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          VSpace(8.h),
                          Text(
                            "Tap to get invoice",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                          ),
                          VSpace(20.h),
                          Text(
                            "Status",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          VSpace(8.h),
                          Text(
                            "Visited",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                          ),
                          VSpace(20.h),
                          Text(
                            "Consultation Type",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          VSpace(8.h),
                          Text(
                            "Follow-up",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            VSpace(20.h),
            Text(
              "Upcoming appointment with Dr.Roland L. Jessen",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            VSpace(20.h),
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  padding: EdgeInsets.only(bottom: 15.h),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: AppColors.getBorderColor(),
                  ))),
                  child: Row(
                    children: [
                      const Text("20 July, 2024  - 10.30"),
                      HSpace(20.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          "Follow-up",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.whiteColor),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
