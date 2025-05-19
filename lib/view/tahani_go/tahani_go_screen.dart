import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/tahani_go/record_screen.dart';

class TahaniGoScreen extends StatefulWidget {
  const TahaniGoScreen({super.key});

  @override
  State<TahaniGoScreen> createState() => _TahaniGoScreenState();
}

class _TahaniGoScreenState extends State<TahaniGoScreen> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'TahaniGo',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Image.asset(AppAssets.tahanigo2, height: 50.h, width: 50.w),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                children: [
                  Container(
                    height: 120.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppAssets.image),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Image.asset(AppAssets.uploadVideos2),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),

                  // 2 container
                  SizedBox(height: 40.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecordScreen()),
                      );
                    },
                    child: Container(
                      height: 120.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.blackColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(AppAssets.image2),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60.w),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecordScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: AppColors.primaryColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.etCamera2,
                                    height: 30.h,
                                    width: 30.w,
                                    color: AppColors.whiteColor,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Record Now',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Container(
                    height: 120.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppAssets.image3),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                'Choose From Gallery',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
