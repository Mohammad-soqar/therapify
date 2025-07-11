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
  final bool showBackButton;
  const DoctorListScreen({super.key, this.showBackButton = true});

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
    _tabController = TabController(
      length: medicalDepartmentData.length,
      vsync: this,
    );

    _tabController.addListener(() {
    
      setState(() {}); // for tab UI
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
    final vm = Provider.of<DoctorListViewModel>(context);

    return Scaffold(
      appBar: CustomAppbar(
        title: "Specialists",
        leading: widget.showBackButton ? [GetBackButton()] : [],
      ),
      body: Column(
        children: [
          // — Search + Filter row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: vm.searchDoctors,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: AppInputDecoration.roundInputDecoration(
                      context: context,
                      hintText: 'Search',
                      fillColor: AppColors.getContainerColor(),
                      borderColor: AppColors.primaryColor
                          .withAlpha((0.2 * 255).toInt()),
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

          // — Department Tabs
          VSpace(5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelColor: AppColors.primaryColor,
              dividerColor: Colors.transparent,
              tabs: medicalDepartmentData.asMap().entries.map((e) {
                final dept = e.value;
                final active = _tabController.index == e.key;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primaryColor
                        : AppColors.getContainerColor(),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    dept.title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color:
                              active ? AppColors.whiteColor : AppColors.getTitleColor(),
                        ),
                  ),
                );
              }).toList(),
            ),
          ),

          // — Doctor List
          Expanded(
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildDoctorList(vm),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorList(DoctorListViewModel vm) {
    if (vm.doctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/no_appointment.png", width: 180.w),
            VSpace(20.h),
            Text("No Doctor Found!", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: vm.doctors.length,
        itemBuilder: (_, idx) => DoctorItem(item: vm.doctors[idx]),
      ),
    );
  }
}
