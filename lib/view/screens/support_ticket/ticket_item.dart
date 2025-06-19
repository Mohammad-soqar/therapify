import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({super.key, required this.index, required this.isRtl});
  final int index;

  final bool isRtl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.getContainerColor(),
          ),
          child: ListTile(
            horizontalTitleGap: 40.w,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 15.h),
            leading: CircleAvatar(
                backgroundColor: AppColors.primaryColor.withAlpha((0 * 255).toInt()),
                child: Image.asset(
                  "assets/icons/ticket.png",
                  width: 24.w,
                  color: AppColors.primaryColor,
                )),
            title: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Text(
                "[123123] Didn't get the remaing 100 likes",
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Text(
              "10th Sep, 2023",
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Positioned(
          left: !isRtl ? 65.w : null,
          right: isRtl ? 65.w : null,
          top: -13.h,
          child: Container(
            height: 28.r,
            width: 28.r,
            decoration: BoxDecoration(
              color: AppColors.getBackgroundColor(),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: !isRtl ? 79.w : null,
          right: isRtl ? 79.w : null,
          bottom: 27.h,
          child: SizedBox(
            height: 80.h,
            child: DottedLine(
              dashLength: 5,
              dashGapLength: 5,
              lineThickness: 1,
              dashColor: AppColors.getBorderColor(),
              direction: Axis.vertical,
            ),
          ),
        ),
        Positioned(
          left: !isRtl ? 65.w : null,
          right: isRtl ? 65.w : null,
          bottom: 7.h,
          child: Container(
            height: 28.r,
            width: 28.r,
            decoration: BoxDecoration(
              color: AppColors.getBackgroundColor(),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
