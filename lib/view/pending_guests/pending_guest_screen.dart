import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/guest_list/widgets/custom_list_tile.dart';

class PendingGuestScreen extends StatefulWidget {
  const PendingGuestScreen({super.key});

  @override
  State<PendingGuestScreen> createState() => _PendingGuestScreenState();
}

class _PendingGuestScreenState extends State<PendingGuestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Image.asset(AppAssets.nav),
        body: SingleChildScrollView(
          child: Column(
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
                    'Pending Guests',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  Image.asset(
                    AppAssets.declinedGuest,
                    height: 35.h,
                    width: 35.w,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
              SizedBox(height: 26.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Column(
                  children: [
                    _TotalApprovedGusts(),
                    _CustomDivider(),
                    SizedBox(height: 20.h),
                    _GuestsApproved(),

                    _CustomDivider(),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Expanded Detailed View',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: AppColors.darkYellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 60.w),
                          child: Center(
                            child: Image.asset(
                              AppAssets.iosUpArrow,
                              height: 12.h,
                              width: 12.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffE2BE67),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.maxFinite,
                              child: Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    child: CustomListTileWidget(
                                      leadingWidget: Image.asset(
                                        AppAssets.greenCheckBox,
                                        height: 16.h,
                                        width: 16.w,
                                      ),
                                      text: 'Name',
                                      widget: Text(
                                        'Ayesha Khan',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    child: CustomListTileWidget(
                                      leadingWidget: Image.asset(
                                        AppAssets.phoneNumber2,
                                        height: 16.h,
                                        width: 16.w,
                                      ),
                                      text: 'Phone Number',
                                      widget: Text(
                                        '0300-1234567',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    child: CustomListTileWidget(
                                      leadingWidget: Image.asset(
                                        AppAssets.seatNo,
                                        height: 16.h,
                                        width: 16.w,
                                      ),
                                      text: 'Seat No',
                                      widget: Text(
                                        '12A',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),

                                    child: CustomListTileWidget(
                                      leadingWidget: Image.asset(
                                        AppAssets.tableLocation,
                                        height: 16.h,
                                        width: 16.w,
                                      ),
                                      text: 'Invite Status',
                                      widget: Text(
                                        'Table 4 - Left Wing',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                          ],
                        );
                      },
                    ),
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

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      width: double.maxFinite,
      color: AppColors.blackColor.withValues(alpha: 0.95),
    );
  }
}

class _TotalApprovedGusts extends StatelessWidget {
  const _TotalApprovedGusts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Unauthorized Guests:',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '(%75 Guests)',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _GuestsApproved extends StatelessWidget {
  const _GuestsApproved({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Percentage of Invited\nGuests Approved:',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '(%25)',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
