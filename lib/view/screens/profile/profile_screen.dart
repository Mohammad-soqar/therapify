import 'package:therapify/view/screens/2fa/two_fa_screen.dart';
import 'package:therapify/view/screens/kyc/kyc_submission_screen.dart';
import 'package:therapify/view/screens/kyc/kyc_verification_screen.dart';
import 'package:therapify/view/screens/profile/change_password_screen.dart';
import 'package:therapify/view/screens/profile/edit_profile_screen.dart' show EditProfileScreen;
import 'package:therapify/view/screens/support_ticket/ticket_screen.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/res/themes/theme_service.dart';
import 'package:therapify/view/screens/profile/logout_dialog.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/spacing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // theme
  final ThemeService themeController = Get.put(ThemeService());
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = themeController.getThemeMode();
    Color getButtonColor(ThemeMode buttonMode) {
      return currentThemeMode == buttonMode
          ? AppColors.primaryColor // Active color
          : AppColors.getContainerColor(); // Inactive color
    }

    // Helper to determine text color
    Color getTextColor(ThemeMode buttonMode) {
      return currentThemeMode == buttonMode
          ? AppColors.whiteColor // Active button text
          : AppColors.getTextColor(); // Inactive button text
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: "Profile",
        leading: [
          InkWell(
            onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BottomAppBar(),
                        ),
                      );
                    },
            child: Container(
              width: 38.r,
              height: 38.r,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColors.getBorderColor()),
              ),
              child: Icon(
                appController.isRtl() ? CupertinoIcons.arrow_right : CupertinoIcons.arrow_left,
                // CupertinoIcons.arrow_left,
                color: AppColors.getTitleColor(),
                size: 18.sp,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    "assets/images/user.png",
                    width: 60.r,
                    height: 60.r,
                    fit: BoxFit.cover,
                  ),
                ),
                HSpace(20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Adam Levine",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    VSpace(10.h),
                    Text("hellojohnjgrubs@gmail.com", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: getButtonColor(ThemeMode.system),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "Auto",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: getTextColor(ThemeMode.system)),
                      ),
                    ),
                  ),
                  // On Button (Dark Mode)
                  InkWell(
                    onTap: () {
                      themeController.changeThemeMode(ThemeMode.dark);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: getButtonColor(ThemeMode.dark),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "On",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: getTextColor(ThemeMode.dark)),
                      ),
                    ),
                  ),
                  // Off Button (Light Mode)
                  InkWell(
                    onTap: () {
                      themeController.changeThemeMode(ThemeMode.light);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: getButtonColor(ThemeMode.light),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "Off",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: getTextColor(ThemeMode.light)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VSpace(20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile Settings",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 10.h),
                ListTile(
                  dense: true,
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 15.w,
                  leading: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.getBackgroundColor(),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Ionicons.create_outline,
                      color: AppColors.getTextColor(),
                      size: 18.sp,
                    ),
                  ),
                  title: Text(
                    "Edit Profile",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    appController.isRtl() ? Ionicons.chevron_back_outline : Ionicons.chevron_forward_outline,
                    size: 16.sp,
                    color: AppColors.getTextColor(),
                  ),
                ),
                listDivider(),
                ListTile(
                  dense: true,
                  onTap: () =>  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChangePasswordScreen(),
                        ),
                      )
                    },
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 15.w,
                  leading: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.getBackgroundColor(),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Ionicons.lock_closed_outline,
                      color: AppColors.getTextColor(),
                      size: 18.sp,
                    ),
                  ),
                  title: Text(
                    "Change Password",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    appController.isRtl() ? Ionicons.chevron_back_outline : Ionicons.chevron_forward_outline,
                    size: 16.sp,
                    color: AppColors.getTextColor(),
                  ),
                ),
                listDivider(),
                ListTile(
                  dense: true,
                  onTap: ()  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TwoFactorScreen(),
                        ),
                      );
                    },
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 15.w,
                  leading: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.getBackgroundColor(),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Ionicons.shield_checkmark_outline,
                      color: AppColors.getTextColor(),
                      size: 18.sp,
                    ),
                  ),
                  title: Text(
                    "2FA Security",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    appController.isRtl() ? Ionicons.chevron_back_outline : Ionicons.chevron_forward_outline,
                    size: 16.sp,
                    color: AppColors.getTextColor(),
                  ),
                ),
                listDivider(),
                ListTile(
                  dense: true,
                  
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 15.w,
                  leading: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.getBackgroundColor(),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Ionicons.id_card_outline,
                      color: AppColors.getTextColor(),
                      size: 18.sp,
                    ),
                  ),
                  
                  

                  title: Text(
                    "Support Ticket",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    appController.isRtl() ? Ionicons.chevron_back_outline : Ionicons.chevron_forward_outline,
                    size: 16.sp,
                    color: AppColors.getTextColor(),
                  ),
                ),
                
                listDivider(),
                ListTile(
                  dense: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const LogoutDialog();
                      },
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 15.w,
                  leading: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.getBackgroundColor(),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Ionicons.log_out_outline,
                      color: AppColors.dangerColor,
                      size: 18.sp,
                    ),
                  ),
                  
                  title: Text(
                    "Sign Out",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.dangerColor),
                  ),
                  trailing: Icon(
                    appController.isRtl() ? Ionicons.chevron_back_outline : Ionicons.chevron_forward_outline,
                    size: 16.sp,
                    color: AppColors.getTextColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  listDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10.h),
          width: Get.width - 89.w,
          child: Divider(
            height: 10.h,
            color: AppColors.getBorderColor(),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
