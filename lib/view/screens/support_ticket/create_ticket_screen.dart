import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/app_button.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/input_decoration.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Create Ticket",
        leading: [GetBackButton()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Subject"),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _subjectController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter subject';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: 'Subject',
                  borderColor: AppColors.getContainerColor(),
                  fillColor: AppColors.getContainerColor(),
                ),
              ),
              SizedBox(height: 20.h),
              const Text("Message"),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _messageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter message';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: AppInputDecoration.roundInputDecoration(
                  context: context,
                  hintText: 'Message',
                  borderColor: AppColors.getContainerColor(),
                  fillColor: AppColors.getContainerColor(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 20.h),
              const Text("Attachments"),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(30.r),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: AppColors.getContainerColor()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/upload.png",
                      width: 52.r,
                      color: AppColors.textColor,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                        decoration:
                            BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(20.r)),
                        child: Text(
                          "Choose Files",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Center(
                child: AppButton(
                  title: "Submit".tr,
                  height: 50.h,
                  width: double.infinity,
                  bgColor: AppColors.primaryColor,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
