import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:therapify/res/themes/theme_service.dart';
import 'package:therapify/view/screens/appointment/appointment_list_screen.dart';
import 'package:therapify/view/screens/doctor/doctor_list_screen.dart';
import 'package:therapify/view/screens/wishlist/wishlist_screen.dart';
import 'package:therapify/view/widgets/curve_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/home/home_screen.dart';
import 'package:therapify/view/screens/profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:therapify/viewmodels/doctor_list_viewmodel.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
      final uid = FirebaseAuth.instance.currentUser!.uid;

  ThemeService themeService = Get.put(ThemeService());
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(), // 0
    ChangeNotifierProvider(
      create: (_) => DoctorListViewModel(),
      child: const DoctorListScreen(showBackButton: false),
    ),
    const WishlistScreen(), // 2 (actually index 3 on screen)
    const ProfileScreen(), // 3
  ];

  final List<String> _icons = [
    "assets/icons/home.png", // index 0
    "assets/icons/doctor_bag.png", // index 1
    "", // index 2 (FAB placeholder)
    "assets/icons/heart.png", // index 3 (Wishlist)
    "assets/icons/user.png", // index 4 (Profile)
  ];

  void _onNavTap(int visualIndex) {
    if (visualIndex == 2) return; // FAB → ignore in navbar
    setState(() {
      _currentIndex = visualIndex > 2 ? visualIndex - 1 : visualIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeService>(builder: (themeService) {
      return Scaffold(
        body: _pages[_currentIndex],
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: FloatingActionButton.small(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>  AppointmentListScreen(patientId: uid,),
                ),
              );
            },
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(Ionicons.calendar_outline,
                size: 18.sp, color: AppColors.whiteColor),
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(bodySmall: const TextStyle(color: Colors.yellow))),
          child: ClipPath(
            clipper: CurveClipper(),
            child: Container(
              height: 65.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_icons.length, (index) {
                  // Skip FAB slot at index 2
                  if (index == 2) {
                    return SizedBox(width: 0); // Reserve space for FAB
                  }

                  double itemWidth = 45.w;
                  bool isSelected =
                      _currentIndex == (index > 2 ? index - 1 : index);

                  return InkWell(
                    onTap: () => _onNavTap(index),
                    child: Container(
                      width: itemWidth,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          child: Image.asset(
                            _icons[index],
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.getTitleColor(),
                            width: 18.r,
                            height: 18.r,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      );
    });
  }
}
