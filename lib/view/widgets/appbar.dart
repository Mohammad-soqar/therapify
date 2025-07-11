import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.bgColor = Colors.transparent,
    this.leading,
    this.action,
    this.bottom,
  });

  final String title;
  final bool? centerTitle;
  final Color bgColor;
  final List<Widget>? leading; // ✅ keeps your existing code working
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
        centerTitle: centerTitle,
        leading: leading != null && leading!.isNotEmpty
            ? Builder(
                builder: (context) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: leading!,
                ),
              )
            : null,
        actions: action,
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
