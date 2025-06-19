import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';

class TwoFactorScreen extends StatefulWidget {
  const TwoFactorScreen({super.key});

  @override
  State<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends State<TwoFactorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "2FA Security",
        leading: [GetBackButton()],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200.r,
                    height: 200.r,
                    padding: EdgeInsets.all(35.r),
                    decoration: BoxDecoration(
                      color: AppColors.getCardColor(),
                      border: Border.all(color: AppColors.getBorderColor()),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Image.asset("assets/icons/two_fa_shield.png"),
                  ),
                  VSpace(20.h),
                  Text(
                    'Two Factor Authenticator',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  VSpace(20.h),
                  Container(
                    padding: EdgeInsets.only(left: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.getBorderColor()),
                    ),
                    child: Row(
                      children: [
                        const Expanded(child: Text("FGH234767UIS2DSF")),
                        InkWell(
                          onTap: () {
                            Utils.toastMessage("Copied");
                          },
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            margin: EdgeInsets.all(5.r),
                            decoration:
                                BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8.r)),
                            child: Icon(Ionicons.copy_outline, color: AppColors.whiteColor, size: 20.sp),
                          ),
                        )
                      ],
                    ),
                  ),
                  VSpace(20.h),
                  Container(
                    width: 170.w,
                    height: 203.h,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: const AssetImage("assets/icons/qr_bg.png"),
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcATop)),
                        border: Border.all(color: AppColors.getBorderColor()),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: QrImageView(
                      data: "twoFaController.twoFactorInfo!.qrCodeUrl",
                      version: QrVersions.auto,
                    ),
                  ),
                  VSpace(20.h),
                  AppButton(
                    title: "Enable Two Factor Authentication",
                    onPress: () {},
                    width: double.infinity,
                    bgColor: AppColors.primaryColor,
                  )
                ],
              ),
              VSpace(10.h),
              Divider(
                height: 50.h,
                color: AppColors.getBorderColor(),
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Use Google Authenticator to Scan the QR code or use the code',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  VSpace(10.h),
                  const Text(
                    "Google Authenticator is a multifactor app for mobile devices. It generates timed codes used during the 2-step verification process. To use Google Authenticator, install the Google Authenticator application on your mobile device.",
                  ),
                  VSpace(20.h),
                  AppButton(
                    title: "Download App",
                    onPress: () {},
                    bgColor: AppColors.primaryColor,
                  )
                ],
              ),
              VSpace(20.h),
            ],
          )),
    );
  }
}
