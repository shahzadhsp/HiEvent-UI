import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_colors.dart';

class EventCostOne extends StatefulWidget {
  const EventCostOne({super.key});
  @override
  State<EventCostOne> createState() => _EventCostOneState();
}

class _EventCostOneState extends State<EventCostOne> {
  // Static data for the table
  final List<Map<String, dynamic>> tableData = [
    {
      'item': 'Venue',
      'description': 'Main hall',
      'quantity': 1,
      'unitPrice': 55000,
      'totalPrice': 55000,
    },
    {
      'item': 'Catering',
      'description': '150 guests',
      'quantity': 150,
      'unitPrice': 550,
      'totalPrice': 7500,
    },
    {
      'item': 'DJ',
      'description': '5 hours',
      'quantity': 5,
      'unitPrice': 1000,
      'totalPrice': 5000,
    },
    {
      'item': 'Flowers & Decor',
      'description': 'Tables & Package',
      'quantity': 1,
      'unitPrice': 2000,
      'totalPrice': 2000,
    },
  ];

  // Helper function to format price without .00
  String formatPrice(num price) {
    return price % 1 == 0
        ? '\$${price.toInt()}'
        : '\$${price.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Event Cost Summary',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      // Table Widget
                      Table(
                        border: TableBorder.all(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          // Table Header
                          TableRow(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                            ),
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Text(
                                    'Item/Service',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Text(
                                    'Qty',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Text(
                                    'Unit Price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Table Data Rows
                          ...tableData.map(
                            (item) => TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Center(
                                    child: Text(
                                      item['item'],
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Center(
                                    child: Text(item['description']),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Center(
                                    child: Text(item['quantity'].toString()),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Center(
                                    child: Text(formatPrice(item['unitPrice'])),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Center(
                                    child: Text(
                                      formatPrice(item['totalPrice']),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Total Row
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                          ),
                        ),
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  formatPrice(
                                    tableData.fold(
                                      0.0,
                                      (sum, item) => sum + item['totalPrice'],
                                    ),
                                  ),
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
