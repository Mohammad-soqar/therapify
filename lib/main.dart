import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:therapify/res/localization/languages.dart';
import 'package:therapify/res/routes/routes.dart';
import 'package:therapify/res/themes/theme.dart';
import 'package:therapify/res/themes/theme_service.dart';
import 'package:therapify/view/screens/splash/splash_screen.dart';


void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppController());

    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(builder: (context) {
        return GetBuilder<AppController>(builder: (appController) {
          return GetMaterialApp(
            textDirection: appController.textDirection,
            debugShowCheckedModeBanner: false,
            title: "doctor_listing",
            translations: Languages(),
            locale: const Locale("en", "US"),
            fallbackLocale: const Locale("en", "US"),
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeService().getThemeMode(),
            home: const SplashScreen(),
            getPages: AppRoutes.appRoutes(),
          );
        });
      }),
    );
  }
}
