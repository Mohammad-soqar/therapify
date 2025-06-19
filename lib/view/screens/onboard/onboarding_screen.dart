import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:therapify/res/routes/routes_name.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:therapify/data/static/onboard_data.dart';
import 'package:therapify/view/screens/auth/signin_screen.dart';
import 'package:therapify/view/screens/onboard/onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  // final AppStepsController controller = Get.put(AppStepsController());
  int _currentPage = 0;

  _markOnboardingAsShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboardingShown', true);
  }

  void _navigateToNextPage() {
    _markOnboardingAsShown();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300), // Animation duration
      curve: Curves.easeInOut, // Animation curve
    );
    if (_currentPage == onboardData.length - 1) {
      Get.offAll(() => const SignInScreen());
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // controller.fetchAppSteps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300), // Animation duration
                          curve: Curves.easeInOut, // Animation curve
                        );
                      },
                      child: Container(
                          width: 40.r,
                          height: 40.r,
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            border: Border.all(color: AppColors.getBorderColor()),
                          ),
                          child: Icon(
                            CupertinoIcons.arrow_left,
                            color: AppColors.getTitleColor(),
                            size: 18.sp,
                          )),
                    ),
                    InkWell(
                        onTap: () {
                          _markOnboardingAsShown();
                          Get.offAllNamed(RoutesName.signInScreen);
                        },
                        child: const Text("Skip")),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: onboardData.length,
                  controller: _pageController,
                  itemBuilder: (context, index) => OnboardingItem(
                    index: index,
                    image: onboardData[index].image,
                    title: onboardData[index].title,
                    description: onboardData[index].subTitle,
                  ),
                ),
              ),
              VSpace(50.h)
            ],
          ),
          Positioned(
            bottom: 50.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularSeekBar(
                  width: 60.r,
                  height: 60.r,
                  progress: _currentPage == 0
                      ? 33.33
                      : _currentPage == 1
                          ? 66.66
                          : 100,
                  barWidth: 3.w,
                  startAngle: 70,
                  sweepAngle: 230,
                  strokeCap: StrokeCap.round,
                  trackColor: AppColors.getBorderColor(),
                  progressGradientColors: [
                    AppColors.primaryColor,
                    AppColors.primaryColor,
                    AppColors.primaryColor,
                  ],
                  dashWidth: 57.h,
                  dashGap: 25.h,
                  animation: true,
                  animDurationMillis: 600,
                  child: InkWell(
                    onTap: _navigateToNextPage,
                    child: Container(
                        margin: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          color: AppColors.whiteColor,
                          size: 22.sp,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
