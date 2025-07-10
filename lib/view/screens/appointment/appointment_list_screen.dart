import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/appointment/appointment_details_screen.dart';
import 'package:therapify/view/screens/appointment/appointment_history_screen.dart';
import 'package:therapify/view/screens/appointment/appointment_item.dart';
import 'package:therapify/view/screens/doctor/doctor_list_screen.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/viewmodels/doctor_list_viewmodel.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabData = ["Upcoming", "Past"];

  // 🔁 TEMP DATA — replace later with Firebase appointments
  final List<DoctorModel> _mockAppointments = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabData.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "My Appointments",
        leading: [GetBackButton()],
      ),
      body: Column(
        children: [
          VSpace(15.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.getContainerColor(),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
              labelColor: AppColors.primaryColor,
              tabs: tabData.asMap().entries.map((entry) {
                String label = entry.value;
                bool isActive = _tabController.index == entry.key;
                return Container(
                  width: double.infinity / 2,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primaryColor
                        : AppColors.getContainerColor(),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: isActive
                              ? AppColors.whiteColor
                              : AppColors.getTitleColor(),
                        ),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabData.map((tab) => _buildTab(tab)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String type) {
    if (_mockAppointments.isNotEmpty) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _mockAppointments.length,
          itemBuilder: (context, index) {
            var item = _mockAppointments[index];
            return InkWell(
              onTap: () {
                if (type == "Upcoming") {
                  Get.to(() => const AppointmentDetailsScreen());
                } else {
                  Get.to(() => const AppointmentHistoryScreen());
                }
              },
              child: AppointmentItem(item: item),
            );
          },
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/no_appointment.png", width: 180.w),
                  VSpace(20.h),
                  Text(
                    "You don’t have an appointment",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  VSpace(50.h),
                ],
              ),
            ),
            AppButton(
              width: double.infinity,
              title: "Book Appointment Now",
              onPress: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChangeNotifierProvider(
  create: (_) => DoctorListViewModel(),
  child: const DoctorListScreen(),
))
              );},
              bgColor: AppColors.primaryColor,
            )
          ],
        ),
      );
    }
  }
}
