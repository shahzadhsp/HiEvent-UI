import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/guest_list/widgets/custom_list_tile.dart';

class GuestListScreen extends StatefulWidget {
  const GuestListScreen({super.key});

  @override
  State<GuestListScreen> createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Image.asset(AppAssets.nav),
        body: Column(
          children: [
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
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Guest List',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                Image.asset(AppAssets.guestList2, height: 40.h, width: 40.w),
              ],
            ),
            SizedBox(height: 26.h),
            Text(
              'Wedding of Sarah & Danielo',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,

                      constraints: BoxConstraints(maxHeight: 33.h),
                      fillColor: AppColors.lightYellow,
                      hintText: 'search...',

                      hintStyle: Theme.of(context).textTheme.bodySmall!
                          .copyWith(color: const Color.fromRGBO(0, 0, 0, 1)),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          child: Image.asset(
                            AppAssets.searchIcon2,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.lightYellow),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            'Import from Phonebook',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.yellow,
                              decorationThickness: 2,
                              color: AppColors.darkYellow,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.lightYellow),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            'Import from Excel',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.yellow,
                              decorationThickness: 2,
                              color: AppColors.darkYellow,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightYellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: CustomListTileWidget(
                            text: 'Name',
                            widget: CircleAvatar(
                              radius: 6.r,
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.blackColor.withValues(alpha: 0.50),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: CustomListTileWidget(
                            text: 'Phone Number',
                            widget: CircleAvatar(
                              radius: 6.r,
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.blackColor.withValues(alpha: 0.50),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),

                          child: CustomListTileWidget(
                            text: 'Invite Status',
                            widget: Icon(Icons.downhill_skiing),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Edit',
                                style: Theme.of(context).textTheme.labelMedium!
                                    .copyWith(color: AppColors.blackColor),
                              ),
                              Image.asset(
                                AppAssets.delete,
                                height: 40.h,
                                width: 40.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.darkYellow,
                            border: Border.all(color: AppColors.darkYellow),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            '+ "Add Manually',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              decorationColor: Colors.yellow,
                              decorationThickness: 2,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 18.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.darkYellow),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text(
                              'Save & Continue',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                decorationColor: Colors.yellow,
                                decorationThickness: 2,
                                color: AppColors.darkYellow,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
