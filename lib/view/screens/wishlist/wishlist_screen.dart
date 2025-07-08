import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/view/screens/wishlist/wishlist_item.dart';
import 'package:therapify/view/widgets/appbar.dart';
import 'package:therapify/view/widgets/back_button.dart';
import 'package:therapify/view/widgets/spacing.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<DoctorModel> _wishlistDoctors = []; // TODO: Replace with Firestore or local DB

  void _removeItem(int index) {
    setState(() {
      _wishlistDoctors.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Wishlist",
        leading: [GetBackButton()],
      ),
      body: _wishlistDoctors.isNotEmpty
          ? SingleChildScrollView(
              padding: EdgeInsets.all(20.r),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _wishlistDoctors.length,
                itemBuilder: (context, index) {
                  var item = _wishlistDoctors[index];
                  return WishlistItem(
                    item: item,
                    onDelete: () => _removeItem(index),
                  );
                },
              ),
            )
          : Container(
              padding: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/no_appointment.png", width: 180.w),
                        VSpace(20.h),
                        Text("No Doctor Found!", style: Theme.of(context).textTheme.titleMedium),
                        VSpace(50.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
