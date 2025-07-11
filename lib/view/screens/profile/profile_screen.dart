import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/res/themes/theme_service.dart';
import 'package:therapify/view/screens/2fa/two_fa_screen.dart';
import 'package:therapify/view/screens/kyc/kyc_submission_screen.dart';
import 'package:therapify/view/screens/kyc/kyc_verification_screen.dart';
import 'package:therapify/view/screens/profile/change_password_screen.dart';
import 'package:therapify/view/screens/profile/edit_profile_screen.dart';
import 'package:therapify/view/screens/profile/logout_dialog.dart';
import 'package:therapify/view/screens/support_ticket/ticket_screen.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ThemeService themeController = Get.put(ThemeService());
  final AppController appController = Get.find<AppController>();

  String _name = 'Loading...';
  String _email = '';
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        final data = doc.data();
        setState(() {
          _name = data?['name'] ?? 'User';
          _email = data?['email'] ?? '';
          _imageUrl = data?['imageUrl'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = themeController.getThemeMode();
    Color getButtonColor(ThemeMode mode) => currentThemeMode == mode
        ? AppColors.primaryColor
        : AppColors.getContainerColor();
    Color getTextColor(ThemeMode mode) => currentThemeMode == mode
        ? AppColors.whiteColor
        : AppColors.getTextColor();

    return Scaffold(
      appBar: CustomAppbar(
        title: "Profile",
        
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: _imageUrl != null
                      ? Image.network(_imageUrl!,
                          width: 60.r, height: 60.r, fit: BoxFit.cover)
                      : Image.asset("assets/images/user.png",
                          width: 60.r, height: 60.r, fit: BoxFit.cover),
                ),
                HSpace(20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_name, style: Theme.of(context).textTheme.titleMedium),
                    VSpace(10.h),
                    Text(_email, style: Theme.of(context).textTheme.bodySmall),
                  ],
                )
              ],
            ),
            VSpace(20.h),
            Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/icons/heading_line.png'),
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcATop,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  "Dark Mode",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            VSpace(20.h),
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColors.getContainerColor(),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Auto Button
                  InkWell(
                    onTap: () {
                      themeController.changeThemeMode(ThemeMode.system);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: getButtonColor(ThemeMode.system),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "Auto",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: getTextColor(ThemeMode.system)),
                      ),
                    ),
                  ),
                  // On Button (Dark Mode)
                  InkWell(
                    onTap: () {
                      themeController.changeThemeMode(ThemeMode.dark);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: getButtonColor(ThemeMode.dark),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "On",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: getTextColor(ThemeMode.dark)),
                      ),
                    ),
                  ),
                  // Off Button (Light Mode)
                  InkWell(
                    onTap: () {
                      themeController.changeThemeMode(ThemeMode.light);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: getButtonColor(ThemeMode.light),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "Off",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: getTextColor(ThemeMode.light)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VSpace(20.h),
            _settingsOption("Edit Profile", Ionicons.create_outline,
                const EditProfileScreen()),
            _settingsOption("Change Password", Ionicons.lock_closed_outline,
                const ChangePasswordScreen()),
            
            ListTile(
              dense: true,
              onTap: () => showDialog(
                  context: context, builder: (_) => const LogoutDialog()),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 15.w,
              leading: Icon(Ionicons.log_out_outline,
                  color: AppColors.dangerColor, size: 18.sp),
              title: Text("Sign Out",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.dangerColor)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeButton(String label, ThemeMode mode,
      Color Function(ThemeMode) bg, Color Function(ThemeMode) text) {
    return InkWell(
      onTap: () => themeController.changeThemeMode(mode),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: bg(mode), borderRadius: BorderRadius.circular(10.r)),
        child: Text(label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: text(mode))),
      ),
    );
  }

  Widget _settingsOption(String title, IconData icon, Widget page) {
    return ListTile(
      dense: true,
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 15.w,
      leading: Icon(icon, color: AppColors.getTextColor(), size: 18.sp),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: Icon(
          appController.isRtl()
              ? Ionicons.chevron_back_outline
              : Ionicons.chevron_forward_outline,
          size: 16.sp,
          color: AppColors.getTextColor()),
    );
  }
}
