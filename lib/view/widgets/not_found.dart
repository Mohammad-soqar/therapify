import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/view/widgets/spacing.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key, required this.image, required this.title, required this.message});

  final String image;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              fit: BoxFit.contain,
              width: 200.w,
            ),
            const VSpace(20),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const VSpace(10),
            Text(message, textAlign: TextAlign.center),
            const VSpace(100),
          ],
        ),
      ),
    );
  }
}
