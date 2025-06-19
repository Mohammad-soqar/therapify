import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppController extends GetxController {
  var textDirection = TextDirection.ltr;

  void setTextDirection(bool isRtl) {
    textDirection = isRtl ? TextDirection.rtl : TextDirection.ltr;
    update();
  }

  bool isRtl() {
    return textDirection == TextDirection.rtl;
  }
}
