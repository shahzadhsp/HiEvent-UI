import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_colors.dart';

class TransltorWidget extends StatelessWidget {
  final String image;
  final String text;
  const TransltorWidget({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, height: 20.h, width: 20.w),
        SizedBox(width: 6.w),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColors.whiteColor),
        ),
      ],
    );
  }
}
