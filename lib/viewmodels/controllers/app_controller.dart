import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:therapify/data/models/user.dart';

class AppController extends GetxController {
  var textDirection = TextDirection.ltr;

  void setTextDirection(bool isRtl) {
    textDirection = isRtl ? TextDirection.rtl : TextDirection.ltr;
    update();
  }

  bool isRtl() {
    return textDirection == TextDirection.rtl;
  }

  UserModel? currentUser;

  void setCurrentUser(UserModel user) async{
    currentUser = user;
    update();
  }
}
