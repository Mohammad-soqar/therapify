import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorReviewsTab extends StatelessWidget {
  const DoctorReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Reviews", style: Theme.of(context).textTheme.titleMedium),
        VSpace(16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.all(20.r),
              decoration:
                  BoxDecoration(color: AppColors.getContainerColor(), borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: Text(
                          "R",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                      HSpace(10.w),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ronald J. Speed",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                                ),
                                VSpace(5.h),
                                Text(
                                  "10th apr 2024",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "4.5",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                VSpace(5.h),
                                RatingBar.builder(
                                  initialRating: double.parse('4.5'),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 16,
                                  itemPadding: EdgeInsets.zero,
                                  ignoreGestures: true,
                                  unratedColor: AppColors.getTextColor().withAlpha((0.2 * 255).toInt()),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    // reviewController.ratingCount = rating;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: AppColors.getBorderColor(),
                    height: 20.h,
                  ),
                  Text(
                    "Flawless office cleaning! The quality of work and cleanliness are exceptional earning them a solid 5 stars.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
