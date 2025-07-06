import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:therapify/data/static/department_data.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/screens/doctor/doctor_filter_sheet.dart';
import 'package:therapify/view/screens/doctor/doctor_item.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/viewmodels/doctor_list_viewmodel.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: medicalDepartmentData.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorViewModel = Provider.of<DoctorListViewModel>(context);

    return Scaffold(
      appBar: const CustomAppbar(
        title: "Specialists",
        leading: [GetBackButton()],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: doctorViewModel.searchDoctors,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: AppInputDecoration.roundInputDecoration(
                      context: context,
                      hintText: 'Search',
                      fillColor: AppColors.getContainerColor(),
                      borderColor: AppColors.primaryColor.withAlpha((0.2 * 255).toInt()),
                      prefixIcon: Image.asset(
                        "assets/icons/search.png",
                        color: AppColors.getTextColor(),
                      ),
                    ),
                  ),
                ),
                HSpace(10.w),
                InkWell(
                  onTap: () => showDoctorFilter(context),
                  child: Container(
                    width: 48.r,
                    height: 48.r,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.asset(
                      "assets/icons/filter.png",
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          VSpace(5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: AppColors.primaryColor,
              tabs: medicalDepartmentData.asMap().entries.map((entry) {
                Department department = entry.value;
                bool isActive = _tabController.index == entry.key;
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primaryColor
                        : AppColors.getContainerColor(),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    department.title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: isActive
                              ? AppColors.whiteColor
                              : AppColors.getTitleColor(),
                        ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: doctorViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildDoctorList(context, doctorViewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorList(BuildContext context, DoctorListViewModel viewModel) {
    final doctors = viewModel.doctors;

    if (doctors.isEmpty) {
      return Container(
        padding: EdgeInsets.all(20.r),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/no_appointment.png", width: 180.w),
              VSpace(20.h),
              Text("No Doctor Found!",
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final item = doctors[index];
          return DoctorItem(item: item);
        },
      ),
    );
  }
}
