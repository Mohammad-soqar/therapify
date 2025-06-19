import 'package:therapify/res/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:therapify/res/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _checkIfOnboardingShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingShown = prefs.getBool('onboardingShown') ?? false;
    // String? authToken = prefs.getString(AppConstants.token);

    if (onboardingShown) {
      // if (authToken != null) {
      // Get.offAllNamed(BottomNavbar.routeName);
      // } else {
      Get.offAllNamed(RoutesName.bottomNavScreen);
      // Get.offAllNamed(RoutesName.signInScreen);
      // Get.offAllNamed(RoutesName.onboardingScreen);
      // }
    } else {
      Get.offAllNamed(RoutesName.onboardingScreen);
    }
  }

  void _initializeState() async {
    Future.delayed(const Duration(seconds: 2), () {
      _checkIfOnboardingShown();
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.getBackgroundColor(),
            child: Image.asset(
              Get.isDarkMode ? "assets/images/splash_bg_dark.png" : "assets/images/splash_bg.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Center(
            child: Container(
              width: 160.r,
              height: 160.r,
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.all(30.r),
              decoration: BoxDecoration(
                  color: AppColors.getContainerColor(),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: AppColors.primaryColor.withAlpha((0.1 * 255).toInt()),
                    width: 4.r,
                  )),
              child: Image.asset(
                "assets/icons/app_icon.png",
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: 80.h,
            left: 0,
            right: 0,
            child: Center(child: Text("DocTime", style: Theme.of(context).textTheme.displayLarge)),
          ),
        ],
      ),
    );
  }
}
