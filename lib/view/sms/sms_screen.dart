import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/sms/widgets/custom_list_tile.dart';

class SmsScreen extends StatefulWidget {
  const SmsScreen({super.key});

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.white,
          child: Row(
            children: [
              Icon(Icons.add, color: Colors.brown[800]),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.brown),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.attach_file,
                        color: Colors.brown[800],
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.photo_camera, color: Colors.brown[800]),
              SizedBox(width: 8),
              Icon(Icons.mic, color: Colors.brown[800]),
            ],
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  TransltorWidget(image: AppAssets.translator, text: 'English'),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('SMS', style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(width: 4.w),
                Image.asset(AppAssets.whiteSmsIcon, height: 30.h, width: 30.w),
              ],
            ),
            SizedBox(height: 18.h),
            Text(
              'Wedding of Sarah & Daniel',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 20.h),

            CustomListTile(
              leadingImage: AppAssets.whatsappLogo,
              text: 'Send on wahtsapp',
              trailingImage: AppAssets.eyeContent,
            ),
            SizedBox(height: 12.h),
            CustomListTile(
              leadingImage: AppAssets.emailLogo,
              text: 'Send on Email',
              trailingImage: AppAssets.eyeContent,
            ),
            SizedBox(height: 14.h),

            CustomListTile(
              leadingImage: AppAssets.roundSSmsIcon,
              text: 'Send on SMS',
              trailingImage: AppAssets.eyeContent,
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 100.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.darkYellow,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),
                      Text(
                        'Send on WhatsApp SMS Invite',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (val) {},
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Colors.green),
                          ),
                          Text(
                            '10 Accepted',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.block, color: AppColors.redColor),
                          ),

                          Text(
                            '8 Rejected',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.maxFinite,
                height: 140.h,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.whiteColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    TextFormField(
                      maxLines: 9,

                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Type Your message here...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          top: 12,
                          left: 12,
                          right: 48,
                          bottom: 36,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.attach_file,
                            color: AppColors.greyColor,
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Attach file",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
