import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:weddinghall/models/cost_model.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';

class EventCostScreen extends StatefulWidget {
  const EventCostScreen({super.key});

  @override
  State<EventCostScreen> createState() => _EventCostScreenState();
}

class _EventCostScreenState extends State<EventCostScreen> {
  int? selectedIndex;
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
                    'Event Costs',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(width: 8.h),
                  Image.asset(AppAssets.eventCost, height: 35.h, width: 35.w),
                ],
              ),
              SizedBox(height: 26.h),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: eventCostPrice.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            setState(() {
                              selectedIndex = index;
                            });
                            final selectedEvent =
                                eventCostPrice[selectedIndex!];
                            await FirebaseFirestore.instance
                                .collection('event_selections')
                                .add({
                                  'eventName': selectedEvent.eventName,
                                  'eventPrice': selectedEvent.eventPrice,
                                  'timestamp': FieldValue.serverTimestamp(),
                                });

                            GetSnackBar(
                              title: 'Success',
                              message: 'Event saved successfully!',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green.shade100,
                              margin: EdgeInsets.all(12),
                              duration: Duration(seconds: 2),
                              borderRadius: 10,
                              isDismissible: true,
                            );
                          },
                          child: Container(
                            height: 90.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.lightYellow
                                      : AppColors.darkYellow,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        eventCostPrice[index].eventName,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium!.copyWith(
                                          fontSize: 18.sp,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Text(
                                        eventCostPrice[index].eventPrice,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AppAssets.edit,
                                        height: 16.h,
                                        width: 16.w,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        'Write about your costs',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(color: AppColors.darkYellow),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 24, color: AppColors.blackColor),
                      SizedBox(width: 2.w),
                      Text(
                        'Add Manually',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          decorationColor: Colors.yellow,
                          decorationThickness: 2,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
