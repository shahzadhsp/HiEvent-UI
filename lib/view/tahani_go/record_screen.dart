import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Image.asset(AppAssets.nav),
        body: Column(
          children: [
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  TransltorWidget(image: AppAssets.translator, text: 'English'),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Text(
              'Wedding of Sarah & Daniel',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 12,
                  ),
                  hintText: 'Recode your message',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: AppColors.blackColor),
                  fillColor: Colors.white,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      AppAssets.blackMic,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Press the button to start recoding your',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              'message',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20.h),
            Image.asset(AppAssets.recordingIcon, height: 60.h, width: 60.w),
            SizedBox(height: 12.h),
            Text('00.00', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
