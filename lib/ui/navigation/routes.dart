// lib/ui/navigation/routes.dart

import 'package:get/get.dart';
import 'package:therapify/view/screens/auth/signin_screen.dart';
import 'package:therapify/view/screens/auth/signup_screen.dart';
import 'package:therapify/view/screens/auth/signin_doctor_screen.dart';
import 'package:therapify/view/screens/auth/signup_doctor_screen.dart';
import 'package:therapify/view/screens/home/home_screen.dart';
import 'package:therapify/res/routes/routes_name.dart';

class AppPages {
  static final getPages = [
    GetPage(
      name: RoutesName.signInScreen,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: RoutesName.signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: RoutesName.signInDoctorScreen,
      page: () => const SignInDoctorScreen(),
    ),
    GetPage(
      name: RoutesName.signUpDoctorScreen,
      page: () => const DoctorSignUpScreen(),
    ),
    GetPage(
      name: RoutesName.homeScreen,
      page: () => const HomeScreen(),
    ),
  ];
}
