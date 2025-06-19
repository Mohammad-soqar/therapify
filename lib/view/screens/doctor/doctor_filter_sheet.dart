import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:therapify/data/static/department_data.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/spacing.dart';

void showDoctorFilter(BuildContext context) {
  List<Department> selectedItems = [];
  List<int> selectedRating = [];
  double low = 100.0;
  double high = 500.0;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Padding to adjust for keyboard
        ),
        child: Wrap(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: AppColors.getBackgroundColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.r),
                  topRight: Radius.circular(0.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Filter By",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const VSpace(20),
                  Divider(
                    height: 1,
                    color: AppColors.getBorderColor(),
                    thickness: 1,
                  ),
                  const VSpace(20),
                  Text(
                    "Category",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.getTitleColor()),
                  ),
                  const VSpace(10),
                  SizedBox(
                    height: 40.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: medicalDepartmentData.length,
                      separatorBuilder: (context, index) => SizedBox(width: 10.w),
                      itemBuilder: (context, index) {
                        final item = medicalDepartmentData[index];
                        final isSelected = selectedItems.contains(item);
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              selectedItems.remove(item);
                            } else {
                              selectedItems.add(item);
                            }
                            (context as Element).markNeedsBuild();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryColor : AppColors.getBackgroundColor(),
                              border:
                                  Border.all(color: isSelected ? AppColors.primaryColor : AppColors.getBorderColor()),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Text(
                              item.title,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 14.sp, color: isSelected ? AppColors.whiteColor : AppColors.getTextColor()),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const VSpace(30),
                  Text(
                    "Price",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.getTitleColor()),
                  ),
                  const VSpace(30),
                  FlutterSlider(
                    values: [low, high],
                    rangeSlider: true,
                    max: 2000,
                    min: 0,
                    handlerWidth: 20.r,
                    handlerHeight: 20.r,
                    tooltip: FlutterSliderTooltip(
                      positionOffset: FlutterSliderTooltipPositionOffset(top: -25),
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      boxStyle: FlutterSliderTooltipBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      alwaysShowTooltip: true,
                    ),
                    handler: FlutterSliderHandler(
                      child: const SizedBox(),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        border: Border.all(
                          color: AppColors.getBackgroundColor(),
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    rightHandler: FlutterSliderHandler(
                      child: const SizedBox(),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        border: Border.all(
                          color: AppColors.getBackgroundColor(),
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    trackBar: FlutterSliderTrackBar(activeTrackBar: BoxDecoration(color: AppColors.primaryColor)),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      low = lowerValue;
                      high = upperValue;
                    },
                  ),
                  const VSpace(30),
                  Text(
                    "Rating",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.getTitleColor()),
                  ),
                  const VSpace(10),
                  SizedBox(
                    height: 40.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      separatorBuilder: (context, index) => SizedBox(width: 10.w),
                      itemBuilder: (context, index) {
                        final isSelected = selectedRating.contains(index);
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              selectedRating.remove(index);
                            } else {
                              selectedRating.add(index);
                            }
                            (context as Element).markNeedsBuild();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryColor : AppColors.getBackgroundColor(),
                              border:
                                  Border.all(color: isSelected ? AppColors.primaryColor : AppColors.getBorderColor()),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.star_fill, size: 16.sp, color: AppColors.warningColor),
                                HSpace(10.w),
                                Text(
                                  index == 0 ? "All" : index.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 14.sp,
                                      color: isSelected ? AppColors.whiteColor : AppColors.getTextColor()),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const VSpace(30),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          title: "Reset",
                          bgColor: AppColors.getContainerColor(),
                          textColor: AppColors.getTextColor(),
                          borderColor: AppColors.getBorderColor(),
                          onPress: () {
                            Get.back();
                          },
                        ),
                      ),
                      const HSpace(10),
                      Expanded(
                        child: AppButton(
                          title: "Filter",
                          bgColor: AppColors.primaryColor,
                          onPress: () {
                            Get.back();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
