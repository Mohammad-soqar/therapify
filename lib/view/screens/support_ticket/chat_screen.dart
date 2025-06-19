import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:therapify/view/widgets/spacing.dart';
import 'package:therapify/viewmodels/controllers/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/utils/utils.dart';
import 'package:therapify/view/screens/support_ticket/close_ticket_dialog.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AppController appController = Get.find<AppController>();
  bool isVisible = false;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Adam Levine",
        leading: const [GetBackButton()],
        action: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CloseTicketDialog();
                },
              );
            },
            child: Container(
              width: 38.r,
              height: 38.r,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColors.getBorderColor()),
              ),
              child: Image.asset(
                "assets/icons/cross.png",
                width: 24.w,
                color: AppColors.getTextColor(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
              reverse: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                // var message = controller.ticketMessages[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5.h),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        width: 250.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r),
                            bottomLeft: Radius.circular(appController.isRtl() ? 0 : 10.r),
                            bottomRight: Radius.circular(appController.isRtl() ? 10.r : 0),
                          ),
                          color: AppColors.primaryColor,
                        ),
                        child: Text(
                          "I have  booked house cleaning service December 13,2024 for 1hour.",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.whiteColor,
                              ),
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        2,
                        (index) {
                          // var attachment = message['attachments'][index];
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5.h),
                              padding: EdgeInsets.only(left: 5.w, top: 5.h, bottom: 5.h, right: 15.w),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(20.r),
                              //   color: AppColors.infoColor,
                              // ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r),
                                  bottomLeft: Radius.circular(appController.isRtl() ? 0 : 10.r),
                                  bottomRight: Radius.circular(appController.isRtl() ? 10.r : 0),
                                ),
                                color: AppColors.infoColor,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.r),
                                    decoration: BoxDecoration(
                                      color: AppColors.getBackgroundColor(),
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    child: Icon(
                                      Icons.cloud_download,
                                      color: AppColors.infoColor,
                                      size: 16.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text("File ${index + 1}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppColors.whiteColor)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: selectedIndex == index,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Text(
                          selectedIndex == index ? Utils.dateFormat(DateTime.now().toString()) : "",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.r),
            padding: EdgeInsets.all(0.r),
            // decoration: BoxDecoration(
            //   color: AppColors.getCardColor(),
            //   borderRadius: BorderRadius.circular(10.r),
            // ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.r),
                      margin: EdgeInsets.only(left: 5.w),
                      decoration: BoxDecoration(
                        color: AppColors.getContainerColor(),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.primaryColor.withAlpha((0.2 * 255).toInt())),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.link,
                          color: AppColors.getTextColor(),
                          size: 18.sp,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5.w,
                      child: Container(
                        width: 16.r,
                        height: 16.r,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            "2",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppColors.whiteColor, fontSize: 10.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                HSpace(8.w),
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          // controller: messageController,
                          onSubmitted: (value) {},
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: AppInputDecoration.roundInputDecoration(
                            fillColor: AppColors.getContainerColor(),
                            borderColor: AppColors.primaryColor.withAlpha((0.2 * 255).toInt()),
                            hintText: 'Type here',
                            context: context,
                            suffixIcon: InkWell(
                              child: Icon(
                                Icons.send,
                                color: AppColors.primaryColor,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
