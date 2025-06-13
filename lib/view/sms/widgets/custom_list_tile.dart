import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';

class CustomListTile extends StatelessWidget {
  final String leadingImage;
  final String text;
  final String trailingImage;
  const CustomListTile({
    super.key,
    required this.leadingImage,
    required this.text,
    required this.trailingImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Row(
            children: [
              Image.asset(leadingImage, height: 50.h, width: 50.w),
              SizedBox(width: 10.w),
              Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: AppColors.whiteColor),
              ),
            ],
          ),
          Image.asset(AppAssets.eyeContent, height: 22.h, width: 22.w),
        ],
      ),
    );
  }
}
