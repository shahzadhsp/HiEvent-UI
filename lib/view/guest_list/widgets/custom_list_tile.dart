import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_colors.dart';

class CustomListTileWidget extends StatelessWidget {
  final String text;
  final Widget widget;
  final Widget? leadingWidget;
  const CustomListTileWidget({
    super.key,
    required this.text,
    required this.widget,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            leadingWidget ??
                Checkbox(
                  value: true,
                  onChanged: (val) {},
                  checkColor: AppColors.darkYellow,
                  fillColor: MaterialStateProperty.all(Colors.green),
                ),
            SizedBox(width: 6.w),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(child: widget),
      ],
    );
  }
}
