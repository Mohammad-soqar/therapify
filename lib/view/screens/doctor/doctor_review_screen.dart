import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DoctorReviewScreen extends StatefulWidget {
  const DoctorReviewScreen({super.key});

  @override
  State<DoctorReviewScreen> createState() => _DoctorReviewScreenState();
}

class _DoctorReviewScreenState extends State<DoctorReviewScreen> {
  final TextEditingController _addressController = TextEditingController();
  String? _recommendation = 'yes';

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Write a Review",
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
                  Container(
                    width: 180.r,
                    height: 180.r,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withAlpha((0.3 * 255).toInt()),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.asset(
                          width: 180.r,
                          height: 180.r,
                          "assets/images/doctor/doctor_4.png",
                        )),
                  ),
                  VSpace(20.h),
                  Text(
                    "How was your experience \n with Dr. Roland Jessen",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  VSpace(20.h),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30.0,
                    unratedColor: AppColors.getBorderColor(),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    onRatingUpdate: (rating) {
                      debugPrint(rating.toString());
                    },
                  ),
                  VSpace(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Write a review",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        "max 500 characters",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  VSpace(10.h),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: AppInputDecoration.roundInputDecoration(
                      context: context,
                      hintText: 'Write your review here',
                      fillColor: AppColors.getContainerColor(),
                      borderColor: AppColors.getContainerColor(),
                    ),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            VSpace(30.h),
            Text("Would you recommend Dr. Roland L. Jessen to your friends?",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp)),
            Row(
              children: [
                Radio<String>(
                  value: 'yes',
                  groupValue: _recommendation,
                  onChanged: (value) {
                    setState(() {
                      _recommendation = value;
                    });
                  },
                ),
                Text('Yes', style: Theme.of(context).textTheme.bodyLarge),
                HSpace(20.w),
                Radio<String>(
                  value: 'no',
                  groupValue: _recommendation,
                  onChanged: (value) {
                    setState(() {
                      _recommendation = value;
                    });
                  },
                ),
                Text('No', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            VSpace(30.h),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: "Cancel",
                    onPress: () => Get.back(),
                    bgColor: AppColors.getContainerColor(),
                    borderColor: AppColors.primaryColor.withAlpha((0.2 * 255).toInt()),
                    width: double.infinity,
                    textColor: AppColors.getTitleColor(),
                  ),
                ),
                HSpace(15.w),
                Expanded(
                  child: AppButton(
                    title: "Submit",
                    onPress: () {
                       Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BottomAppBar(),
                        ),
                      );;
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
