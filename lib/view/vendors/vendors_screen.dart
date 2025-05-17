import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/models/vendors.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/vendors/widget/custom_card.dart';

class VendorsScreen extends StatefulWidget {
  const VendorsScreen({super.key});

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Image.asset(AppAssets.nav),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    TransltorWidget(
                      image: AppAssets.translator,
                      text: 'English',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Vendors',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(width: 12.h),
                  Image.asset(
                    AppAssets.vendors,
                    height: 35.h,
                    width: 35.w,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(28.w, 0, 50.w, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete your vendor team',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Find and book your vendors step by step',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium!.copyWith(height: 4.5),
                    ),
                    SizedBox(height: 10.h),
                    Text('2/9 Services Booked'),
                    SizedBox(height: 6.h),
                    Stack(
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        Container(
                          width: 140.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: AppColors.darkYellow,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    CustomCard(
                      image: AppAssets.cameraMan,
                      text: 'Photographers',
                    ),
                    SizedBox(height: 10.h),

                    CustomCard(image: AppAssets.makeUp, text: 'Make-up'),

                    SizedBox(height: 10.h),
                    CustomCard(
                      image: AppAssets.selfie,
                      text: ' Selfie Photography',
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Top Vendors',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 220.w,
                            margin: EdgeInsets.only(right: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.asset(
                                    index == 0
                                        ? AppAssets.flower
                                        : AppAssets.clothing,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '01',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Lily Flowers',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      Text(
                                        'Florist',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      'Vendors',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: vendorsList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.asset(
                                    vendorsList[index].image,
                                    width: 70.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  vendorsList[index].text,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
