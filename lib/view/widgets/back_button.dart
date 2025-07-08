import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';

class GetBackButton extends StatefulWidget {
  const GetBackButton({super.key});

  @override
  State<GetBackButton> createState() => _GetBackButtonState();
}

class _GetBackButtonState extends State<GetBackButton> {
  final bool isBottomNav = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isBottomNav
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const BottomAppBar(),
                ),
              )
            : Get.back();
      },
      child: Container(
          width: 38.r,
          height: 38.r,
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(color: AppColors.getBorderColor()),
          ),
          child: Icon(
            Get.find<AppController>().isRtl()
                ? CupertinoIcons.arrow_right
                : CupertinoIcons.arrow_left,
            color: AppColors.getTitleColor(),
            size: 18.sp,
          )),
    );
  }
}
