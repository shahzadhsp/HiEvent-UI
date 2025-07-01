import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/config/enums.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';

class TableConfirmationScreen extends StatelessWidget {
  final TableNumber tableName;
  final TableShape tableShape;
  final int chairCount;
  final String selectedSide;

  const TableConfirmationScreen({
    required this.tableName,
    required this.tableShape,
    required this.chairCount,
    required this.selectedSide,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: AppColors.whiteColor),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Booking Confirmation',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColors.whiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Table Name: ${tableName.label}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: AppColors.whiteColor),
            ),
            Text(
              'Shape: ${tableShape.name}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: AppColors.whiteColor),
            ),
            Text(
              'Chairs: $chairCount',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: AppColors.whiteColor),
            ),
            Text(
              'Side: $selectedSide',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: AppColors.whiteColor),
            ),
            // here show image of the selected table
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300.h,
                    width: 400.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Top chairs
                        if (chairCount >= 2)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              chairCount == 2
                                  ? 1
                                  : chairCount == 4
                                  ? 1
                                  : chairCount == 6
                                  ? 2
                                  : 2, // Top chairs count
                              (index) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Image.asset(
                                  AppAssets.chair,
                                  height: 40.h,
                                  width: 40.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        if (chairCount >= 2) SizedBox(height: 6.h),
                        // Middle row with side chairs
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Left chairs
                            if (chairCount >= 4)
                              Column(
                                children: List.generate(
                                  chairCount == 4
                                      ? 1
                                      : chairCount == 6
                                      ? 1
                                      : 2, // Left chairs count
                                  (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Image.asset(
                                      AppAssets.chair,
                                      height: 40.h,
                                      width: 40.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            if (chairCount >= 4) SizedBox(width: 6.w),
                            // Table
                            Image.asset(
                              tableShape == TableShape.round
                                  ? AppAssets.table
                                  : tableShape == TableShape.square
                                  ? AppAssets.table2
                                  : AppAssets.table3,
                              height:
                                  tableShape == TableShape.rectangle
                                      ? 60.h
                                      : 80.h,
                              width:
                                  tableShape == TableShape.rectangle
                                      ? 100.w
                                      : 80.w,
                              fit: BoxFit.contain,
                            ),
                            if (chairCount >= 4) SizedBox(width: 6.w),
                            // Right chairs
                            if (chairCount >= 4)
                              Column(
                                children: List.generate(
                                  chairCount == 4
                                      ? 1
                                      : chairCount == 6
                                      ? 1
                                      : 2,
                                  (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Image.asset(
                                      AppAssets.chair,
                                      height: 40.h,
                                      width: 40.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        if (chairCount >= 2) SizedBox(height: 6.h),
                        // Bottom chairs
                        if (chairCount >= 2)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              chairCount == 2
                                  ? 1
                                  : chairCount == 4
                                  ? 1
                                  : chairCount == 6
                                  ? 2
                                  : 2, // Bottom chairs count
                              (index) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Image.asset(
                                  AppAssets.chair,
                                  height: 40.h,
                                  width: 40.w,
                                  color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
