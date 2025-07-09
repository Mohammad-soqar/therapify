import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/data/static/department_data.dart';
import 'package:therapify/data/static/doctor_data.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/screens/appointment/appointment_list_screen.dart';
import 'package:therapify/view/screens/department/department_item.dart';
import 'package:therapify/view/screens/doctor/doctor_filter_sheet.dart';
import 'package:therapify/view/screens/doctor/doctor_item.dart';
import 'package:therapify/view/screens/doctor/doctor_list_screen.dart';
import 'package:therapify/view/screens/home/notification_button.dart';
import 'package:therapify/view/screens/messaging/messages_screen.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/side_drawer.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:provider/provider.dart';
import 'package:therapify/viewmodels/doctor_list_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppController appController = Get.find<AppController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  String _fullName = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _fullName = 'Guest';
      });
      return;
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      if (doc.exists) {
        final data = doc.data();
        _fullName = data?['name'] ?? 'User';
      } else {
        _fullName = 'User';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            const VSpace(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: openDrawer,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        child: Image.asset(
                          "assets/images/user.png",
                          width: 44.r,
                        ),
                      ),
                    ),
                    const HSpace(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _fullName != null
                              ? "Welcome,\n$_fullName"
                              : "Loading...",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.getTitleColor()),
                        ),
                        Text(
                          "How are you feeling today?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.getTextColor()),
                        ),
                      ],
                    )
                  ],
                ),
                HSpace(10.w),
                Row(
                  children: [
                    const NotificationButton(notificationCount: 2),
                    SizedBox(width: 8.w),
                    IconButton(
                      icon: Icon(Icons.message_rounded,
                          color: AppColors.getTextColor()),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MessagesScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            VSpace(20.h),
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: AppInputDecoration.roundInputDecoration(
                        context: context,
                        hintText: 'Search here',
                        fillColor: AppColors.getContainerColor(),
                        borderColor: AppColors.primaryColor
                            .withAlpha((0.2 * 255).toInt()),
                        prefixIcon: Image.asset(
                          "assets/icons/search.png",
                          color: AppColors.getTextColor2(),
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
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Image.asset(
                        "assets/icons/filter.png",
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VSpace(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Schedule",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AppointmentListScreen()));
                  },
                  child: Text(
                    "See All",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            VSpace(15.h),
            Container(
              width: double.infinity,
              height: 165.h,
              margin: EdgeInsets.only(bottom: 15.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withAlpha((0.8 * 255).toInt()),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      appController.isRtl()
                          ? "assets/images/appointment_bg_2.png"
                          : "assets/images/appointment_bg.png",
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      color:
                          AppColors.primaryColor.withAlpha((0.8 * 255).toInt()),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          flex: 3,
                          child:
                              Image.asset("assets/images/doctor/doctor_6.png")),
                      Flexible(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr. James B. Mummert",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: 16.sp),
                              ),
                              VSpace(6.h),
                              Text(
                                "Depression",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                              VSpace(10.h),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: const Border(
                                        left: BorderSide(
                                            color: AppColors.whiteColor))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.clock_solid,
                                      color: AppColors.whiteColor,
                                      size: 12.sp,
                                    ),
                                    HSpace(5.w),
                                    //TODO: Replace with actual appointment time
                                    Text(
                                      Utils.dateFormat(
                                          DateTime.now().toString()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize: 12.sp,
                                              color: AppColors.whiteColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            VSpace(15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                InkWell(
onTap: () {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => DoctorListViewModel(),
            child: const DoctorListScreen(),
          ),
      ),
  );
                  },
                  child: Text(
                    "See All",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            const VSpace(15),
            SizedBox(
              height: 80.h,
              child: ListView.builder(
                itemCount: medicalDepartmentData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var item = medicalDepartmentData[index];
                  return Container(
                    margin: EdgeInsets.only(right: 10.w),
                    child: DepartmentItem(item: item),
                  );
                },
              ),
            ),
            const VSpace(25),
            const SpecialistsSection(),
          ],
        ),
      ),
    );
  }
}

class SpecialistsSection extends StatelessWidget {
  const SpecialistsSection({super.key});

  bool isTablet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 600;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DoctorListViewModel>(context);
    final isTabletDevice = isTablet(context);
    final doctorDisplayCount = isTabletDevice ? 6 : 3;

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final doctors = viewModel.doctors.take(doctorDisplayCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Specialist",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            InkWell(
              onTap: () {
Navigator.push(
    context,
    MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => DoctorListViewModel(),
          child: const DoctorListScreen(),
        ),
    ),
);
              },
              child: Text(
                "See All",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
        const VSpace(15),
        doctors.isEmpty
            ? Text("No doctors available")
            : Column(
                children:
                    doctors.map((item) => DoctorItem(item: item)).toList(),
              ),
      ],
    );
  }
}
