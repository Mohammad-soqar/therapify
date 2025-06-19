import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';

class Utils {
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message, {Color bgColor = AppColors.successColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: AppColors.whiteColor,
      fontSize: 14,
    );
  }

  static snackBar(String title, String message) {
    Get.snackbar(title, message);
  }

  static dateFormat(dynamic time) {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('d MMM, yy hh:mm a').format(dateTime);
  }

  static List<BoxShadow> defaultBoxShadow() {
    return [
      BoxShadow(
        color: AppColors.getShadowColor(),
        blurRadius: 4,
        spreadRadius: 0,
        offset: const Offset(0, 2),
      ),
    ];
  }
}
