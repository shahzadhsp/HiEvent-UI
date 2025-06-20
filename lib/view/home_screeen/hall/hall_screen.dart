import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/config/enums.dart';
import 'package:weddinghall/controllers/hall_screen_controller.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';

class HallScreen extends StatefulWidget {
  const HallScreen({super.key});

  @override
  State<HallScreen> createState() => _HallScreenState();
}

class _HallScreenState extends State<HallScreen> {
  final tableShapes = TableShape.values;
  TableNumber? selectedTable;
  bool isLoading = false;

  TableShape selectedTableShape = TableShape.round;

  String selectedSide = 'Left';
  int chairCount = 0;
  List<String> tableList = [
    AppAssets.table,
    AppAssets.table2,
    AppAssets.table3,
  ];

  final List<TableNumber> tableNumbers = TableNumber.values;

  int selectedValue = 0;
  List<String> tableRowOne = ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8'];
  List<String> tableRowTwp = ['A1', 'A2', 'A3', 'A4'];

  TableShape tableShape = TableShape.round;
  int selectTable = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 20.r,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    TransltorWidget(
                      image: AppAssets.englishIcon,
                      text: 'English',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hall/Auditorium',
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(color: AppColors.whiteColor),
                    ),
                    SizedBox(width: 4.w),
                    Image.asset(
                      AppAssets.hallLogo,
                      height: 30.h,
                      width: 30.w,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: AppColors.lightYellow,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r),
                                topLeft: Radius.circular(10.r),
                                bottomLeft: Radius.circular(10.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Hall',
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r),
                                topLeft: Radius.circular(10.r),
                                bottomLeft: Radius.circular(10.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Auditorium',
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Table',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(tableNumbers.length, (index) {
                    final table = tableNumbers[index];
                    final isSelected = selectedTable == table;
                    return Expanded(
                      child: InkWell(
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        onTap: () {
                          setState(() {
                            selectedTable = table;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.darkYellow
                                      : AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(
                                    tableList[index],
                                    height: 60.h,
                                    width: index == 2 ? 120.h : 50.w,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  table.label,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall!.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  'No of chairs',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall!.copyWith(
                                    color: AppColors.blackColor,
                                    fontSize: 7.sp,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  width: 60.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.greyColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withValues(
                                          alpha: 0.2,
                                        ),
                                        offset: Offset(0, 4),
                                        blurRadius: 6,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.greyColor,
                                            borderRadius: BorderRadius.circular(
                                              4.r,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.2,
                                                ),
                                                offset: Offset(4, 0),
                                                blurRadius: 6,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              '10',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelSmall!.copyWith(
                                                color: AppColors.blackColor,
                                                fontSize: 8.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(width: 2.w),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              chairCount++;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.greyColor,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withValues(
                                                    alpha: 0.2,
                                                  ),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 6,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                '+',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontSize: 8.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Choose Table Shape',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      Row(
                        children: List.generate(tableShapes.length, (index) {
                          final shape = tableShapes[index];
                          final isSelected = shape == selectedTableShape;

                          return InkWell(
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            onTap: () {
                              setState(() {
                                selectedTableShape = shape;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? AppColors.lightYellow
                                          : AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(60.r),
                                ),
                                child: Center(
                                  child: Text(
                                    shape.label,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall!.copyWith(
                                      color:
                                          isSelected
                                              ? AppColors.whiteColor
                                              : AppColors.blackColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'No of Chairs',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        color: AppColors.greyColor,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                '$chairCount',
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall!.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  chairCount++;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  '+',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall!.copyWith(
                                    color: AppColors.blackColor,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Flexible Layout Builder',
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Row 1',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: List.generate(8, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AppColors.darkYellow,
                                    child: Text(
                                      tableRowOne[index],
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall!.copyWith(
                                        color: AppColors.blackColor,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Row 2',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: List.generate(4, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AppColors.darkYellow,
                                    child: Text(
                                      tableRowTwp[index],
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall!.copyWith(
                                        color: AppColors.blackColor,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 90.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: AppColors.darkYellow,
                                    child: Image.asset(AppAssets.person),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Row 1',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Table 2',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Text(
                                'Emaan Parker',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Accessebility',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '  Meal Prefrences',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          color: AppColors.whiteColor,
                          height: 20.h,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Container(
                          color: AppColors.whiteColor,
                          height: 20.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: Text(
                      'Stage',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 7.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// Left Button
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedSide = 'Left';
                          });
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 8.r,
                                  backgroundColor: AppColors.whiteColor,
                                ),
                                if (selectedSide == 'Left')
                                  Positioned(
                                    left: 3,
                                    right: 3,
                                    top: 3,
                                    bottom: 3,
                                    child: CircleAvatar(
                                      radius: 5.r,
                                      backgroundColor: AppColors.darkYellow,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Left',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),

                      /// Right Button
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedSide = 'Right';
                          });
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 8.r,
                                  backgroundColor: AppColors.whiteColor,
                                ),
                                if (selectedSide == 'Right')
                                  Positioned(
                                    left: 3,
                                    right: 3,
                                    top: 3,
                                    bottom: 3,
                                    child: CircleAvatar(
                                      radius: 5.r,
                                      backgroundColor: AppColors.darkYellow,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Right',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    foregroundColor: AppColors.blackColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 80.h,
                    ),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Print',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    log('selected table$selectTable');
                    log('selected table shape$selectedTableShape');
                    log('chair count$chairCount');
                    log('selected side$selectedSide');
                    await saveBooking(
                      context: context,
                      selectedTable: selectedTable!,
                      selectedShape: selectedTableShape,
                      selectedSide: selectedSide,
                      chairCount: chairCount,
                    );
                    setState(() {
                      isLoading = false;
                    });
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    foregroundColor: AppColors.blackColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 80.h,
                    ),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      isLoading
                          ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black,
                              ),
                            ),
                          )
                          : Text(
                            'Save',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: AppColors.blackColor),
                          ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
