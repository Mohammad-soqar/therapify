import 'package:therapify/data/static/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/spacing.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.item});
  final TransactionModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            margin: EdgeInsets.only(top: 8.h),
            child: Image.asset(
              item.image,
              fit: BoxFit.cover,
              width: 24.w,
            ),
          ),
          HSpace(15.w),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(bottom: 10.h),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.getBorderColor())),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      VSpace(5.h),
                      Text(
                        item.date,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                      ),
                      VSpace(5.h),
                    ],
                  ),
                  Text(
                    item.amount,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
