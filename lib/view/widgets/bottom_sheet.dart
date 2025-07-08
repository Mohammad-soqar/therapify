import 'package:therapify/view/screens/payment/payment_preview_screen.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/dropdown_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:get/get.dart';

void showCustomModalBottomSheet(BuildContext context) {
  bool isRemember = false;
  List<dynamic> currencies = ["USD", "NGN", "RUB", "GBP", "AUD", "BDT"];
  String? selectedCurrency;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
              color: AppColors.getBackgroundColor(),
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(20.r),
              //   topRight: Radius.circular(20.r),
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Amount"),
                VSpace(10.h),
                TextFormField(
                  // controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: AppInputDecoration.roundInputDecoration(
                    context: context,
                    hintText: 'Enter Amount',
                    fillColor: AppColors.getContainerColor(),
                    borderColor: AppColors.getContainerColor(),
                  ),
                ),
                VSpace(20.h),
                const Text("Select Currency"),
                VSpace(10.h),
                SearchableDropdown(
                  dropdownItems: currencies,
                  selectedItem: selectedCurrency,
                  hintText: "Select Currency",
                  onChanged: (String? value) {
                    if (value != null) {
                      selectedCurrency = value;
                    }
                  },
                ),
                VSpace(20.h),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1,
                      child: Checkbox(
                        checkColor: AppColors.whiteColor,
                        activeColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.r)),
                        visualDensity: const VisualDensity(
                            horizontal: -4.0, vertical: -4.0), // adjust padding
                        side: BorderSide(color: AppColors.getBorderColor()),
                        value: isRemember,
                        onChanged: (bool? value) {
                          isRemember = value!;
                        },
                      ),
                    ),
                    Text(
                      "I agree to terms & condition",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                VSpace(30.h),
                AppButton(
                    title: "Make Payment",
                    onPress: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaymentPreviewScreen(),
                        ),
                      );
                    },
                    width: double.infinity,
                    bgColor: AppColors.primaryColor)
              ],
            ),
          ),
        ],
      );
    },
  );
}
