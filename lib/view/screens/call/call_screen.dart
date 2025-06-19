import 'dart:math';
import 'package:therapify/res/constants/app_constants.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  String callID = Get.arguments;
  final userID = Random().nextInt(1000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
        appID: int.parse(AppConstants.zegoCloudAppId),
        appSign: AppConstants.zegoCloudAppSign,
        userID: userID.toString(),
        userName: "username$userID",
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..turnOnMicrophoneWhenJoining = true
          ..turnOnCameraWhenJoining = true,
        onDispose: () {
          Future.delayed(Duration.zero, () {
            Get.offAllNamed(RoutesName.sessionCompleteScreen);
          });
        },
      ),
    );
  }
}
