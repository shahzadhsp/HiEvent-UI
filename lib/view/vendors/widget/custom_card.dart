import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_colors.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final String image;
  const CustomCard({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.darkYellow,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: ListTile(
          leading: Container(
            height: 200.h,
            width: 65.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset(image),
          ),
          title: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Shortlisted : 3 | Booked : 1',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColors.blackColor,
              height: 3.5,
            ),
          ),
        ),
      ),
    );
  }
}
