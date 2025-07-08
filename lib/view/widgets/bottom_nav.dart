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
  ThemeService themeService = Get.put(ThemeService());
  int _currentIndex = 0;

final List<Widget> _pages = [
  const HomeScreen(),
  ChangeNotifierProvider(
    create: (_) => DoctorListViewModel(),
    child: const DoctorListScreen(),
  ),
  const WishlistScreen(),
  const ProfileScreen(),
];

  final List<String> _icons = [
    "assets/icons/home.png",
    "assets/icons/doctor_bag.png",
    "assets/icons/pie.png",
    "assets/icons/heart.png",
    "assets/icons/user.png",
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeService>(builder: (themeService) {
      return Scaffold(
        body: _pages[_currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: FloatingActionButton.small(
            onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AppointmentListScreen(),
                        ),
                      );
                    },
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(Ionicons.calendar_outline, size: 18.sp, color: AppColors.whiteColor),
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.copyWith(bodySmall: const TextStyle(color: Colors.yellow))),
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
                  double itemWidth = 45.w;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: Container(
                      width: index != 2 ? itemWidth : 0,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          child: Image.asset(
                            _icons[index],
                            color: _currentIndex == index ? AppColors.primaryColor : AppColors.getTitleColor(),
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
