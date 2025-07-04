import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/utils/utills.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/guest_list/widgets/custom_list_tile.dart';

class DeclinedListScreen extends StatefulWidget {
  const DeclinedListScreen({super.key});

  @override
  State<DeclinedListScreen> createState() => _DeclinedListScreenState();
}

class _DeclinedListScreenState extends State<DeclinedListScreen> {
  final DeletedGuestsService _deletedGuestsService = DeletedGuestsService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Image.asset(AppAssets.nav),
        body: Column(
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  TransltorWidget(image: AppAssets.translator, text: 'English'),
                ],
              ),
            ),
            SizedBox(height: 6.h),

            // Title Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Declined Guests',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.whiteColor,
                  ),
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

            // Main Content Area (scrollable)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Column(
                  children: [
                    // _TotalDeclinedGuests(),
                    _TotalApprovedGusts(),
                    _CustomDivider(),
                    SizedBox(height: 20.h),
                    _GuestsDeclinedPercentage(),
                    _CustomDivider(),
                    SizedBox(height: 20.h),
                    // Expanded View Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Expanded Detailed View',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.darkYellow),
                        ),
                        Image.asset(
                          AppAssets.iosUpArrow,
                          height: 12.h,
                          width: 12.w,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    // Deleted Guests List
                    Expanded(
                      child: StreamBuilder<List<DocumentSnapshot>>(
                        stream:
                            _deletedGuestsService.getCombinedDeletedGuests(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("No declined guests found"),
                            );
                          }

                          final deletedGuests = snapshot.data!;

                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: deletedGuests.length,
                            itemBuilder: (context, index) {
                              final guest = deletedGuests[index];
                              final data = guest.data() as Map<String, dynamic>;

                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffE2BE67),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.h),

                                      SizedBox(height: 10.h),
                                      _buildDeletedListTile(
                                        context,
                                        AppAssets.greenCheckBox,
                                        'Name',
                                        data['name'] ?? 'No name',
                                      ),
                                      _buildDeletedListTile(
                                        context,
                                        AppAssets.phoneNumber2,
                                        'Phone Number',
                                        data['phone'] ?? 'No phone',
                                      ),
                                      _buildDeletedListTile(
                                        context,
                                        AppAssets.seatNo,
                                        'Seat No',
                                        data['seatNo'] ??
                                            data['seat'] ??
                                            'Not assigned',
                                      ),
                                      _buildDeletedListTile(
                                        context,
                                        AppAssets.tableLocation,
                                        'Table Location',
                                        data['tableNo'] ??
                                            data['table'] ??
                                            'Not assigned',
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
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

Widget _buildDeletedListTile(
  BuildContext context,
  String icon,
  String label,
  String value,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
    child: CustomListTileWidget(
      leadingWidget: Image.asset(icon, height: 16.h, width: 16.w),
      text: label,
      widget: Text(
        value,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: AppColors.blackColor),
      ),
    ),
  );
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
          'Total Approved Guests:',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
        Text(
          '(%75 Guests)',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}

// class _GuestsApproved extends StatelessWidget {
//   const _GuestsApproved({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Percentage of Invited\nGuests Declined:',
//           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//             fontWeight: FontWeight.bold,
//             color: AppColors.whiteColor,
//           ),
//         ),
//         Text(
//           '(%25)',
//           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//             fontWeight: FontWeight.bold,
//             color: AppColors.whiteColor,
//           ),
//         ),
//       ],
//     );
//   }
// }

class _GuestsDeclinedPercentage extends StatelessWidget {
  const _GuestsDeclinedPercentage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Percentage of Invited\nGuests Declined:',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
        StreamBuilder<double>(
          stream: _calculateDeclinedPercentage(),
          builder: (context, snapshot) {
            final percentage = snapshot.data ?? 0.0;
            return Text(
              '(${percentage.toStringAsFixed(0)}%)',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: _getPercentageColor(percentage),
              ),
            );
          },
        ),
      ],
    );
  }

  Stream<double> _calculateDeclinedPercentage() {
    final deletedStream = DeletedGuestsService().getCombinedDeletedGuests();
    final totalStream = getTotalGuestsCount();

    return CombineLatestStream.combine2(deletedStream, totalStream, (
      List<DocumentSnapshot> deletedGuests,
      int totalGuests,
    ) {
      if (totalGuests == 0) return 0.0;
      return (deletedGuests.length / totalGuests) * 100;
    });
  }

  Color _getPercentageColor(double percentage) {
    if (percentage >= 75) return Colors.white;
    if (percentage >= 50) return Colors.white;
    if (percentage >= 25) return Colors.white;
    return Colors.white;
  }
}
