import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:therapify/res/localization/languages.dart';
import 'package:therapify/res/routes/routes.dart';
import 'package:therapify/res/themes/theme.dart';
import 'package:therapify/res/themes/theme_service.dart';
import 'package:therapify/view/screens/auth/signin_screen.dart';
import 'package:therapify/view/screens/home/home_screen.dart';
import 'package:therapify/view/widgets/bottom_nav.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:therapify/viewmodels/doctor_list_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  await ScreenUtil.ensureScreenSize();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject global AppController
    Get.put(AppController());

    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(
        builder: (context) {
          return GetBuilder<AppController>(
            builder: (appController) {
              return GetMaterialApp(
                textDirection: appController.textDirection,
                debugShowCheckedModeBanner: false,
                title: 'doctor_listing',
                translations: Languages(),
                locale: const Locale('en', 'US'),
                fallbackLocale: const Locale('en', 'US'),
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: ThemeService().getThemeMode(),
                home: const AuthWrapper(),
              );
            },
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
              create: (_) => DoctorListViewModel(),
              child: const BottomNavbar(),
            );
          }
          return const SignInScreen();
        }
      },
    );
  }
}
