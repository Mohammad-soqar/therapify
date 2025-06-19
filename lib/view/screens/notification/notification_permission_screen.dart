import 'package:therapify/res/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPermissionScreen extends StatefulWidget {
  const NotificationPermissionScreen({super.key});

  @override
  State<NotificationPermissionScreen> createState() => _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState extends State<NotificationPermissionScreen> {
  bool switchValue = false;
  final List<dynamic> _notificationPermissions = [
    "Profile Update",
    "KYC Approval",
    "KYC Rejection",
    "Ticket Reply",
    "Balance",
    "Fund Add",
    "Payout Status"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Notification Permission",
        leading: [GetBackButton()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _notificationPermissions.length,
          itemBuilder: (context, index) {
            final item = _notificationPermissions[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColors.getContainerColor(),
                // border: Border.all(
                //   color: AppColors.primaryColor.withAlpha((0.1 * 255).toInt()),
                // ),
              ),
              child: ExpansionTile(
                shape: Border.all(color: Colors.transparent),
                tilePadding: EdgeInsets.zero,
                iconColor: AppColors.primaryColor,
                collapsedTextColor: AppColors.getTitleColor(),
                textColor: AppColors.primaryColor,
                title: Text(
                  item,
                  maxLines: 1,
                ),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text("Email", style: Theme.of(context).textTheme.bodyMedium),
                    trailing: Transform.scale(
                      scale: .7,
                      child: CupertinoSwitch(
                        value: switchValue,
                        activeTrackColor: AppColors.primaryColor,
                        onChanged: (value) {
                          switchValue = !switchValue;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text("Sms", style: Theme.of(context).textTheme.bodyMedium),
                    trailing: Transform.scale(
                      scale: .7,
                      child: CupertinoSwitch(
                        value: switchValue,
                        activeTrackColor: AppColors.primaryColor,
                        onChanged: (value) {
                          switchValue = !switchValue;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text("Push", style: Theme.of(context).textTheme.bodyMedium),
                    trailing: Transform.scale(
                      scale: .7,
                      child: CupertinoSwitch(
                        value: switchValue,
                        activeTrackColor: AppColors.primaryColor,
                        onChanged: (value) {
                          switchValue = !switchValue;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text("In App", style: Theme.of(context).textTheme.bodyMedium),
                    trailing: Transform.scale(
                      scale: .7,
                      child: CupertinoSwitch(
                        value: switchValue,
                        activeTrackColor: AppColors.primaryColor,
                        onChanged: (value) {
                          switchValue = !switchValue;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
