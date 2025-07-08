import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:therapify/view/screens/doctor/doctor_list_screen.dart';
import 'package:therapify/viewmodels/doctor_list_viewmodel.dart';

class RoutesName {
  static const String doctorListScreen = '/doctorListScreen';

  // Add other route names here if needed
}

class AppRoutes {
  static List<GetPage> appRoutes() {
    return [
      // 👇 Route for Doctor List Screen with Provider
      GetPage(
        name: RoutesName.doctorListScreen,
        page: () => ChangeNotifierProvider(
          create: (_) => DoctorListViewModel(),
          child: const DoctorListScreen(),
        ),
      ),

      // Add other routes below using GetPage if needed
    ];
  }
}
