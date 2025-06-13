import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/utils/utills.dart';
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
                    StreamBuilder<List<DocumentSnapshot>>(
                      stream: combinedGuestsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              strokeWidth: 2.w,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No guests found'));
                        }

                        final allGuests = snapshot.data!;
                        return ListView.builder(
                          itemCount: allGuests.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final guest = allGuests[index];
                            final data =
                                guest.data() as Map<String, dynamic>? ?? {};
                            final isBooking = guest.reference.path.contains(
                              'booking',
                            );
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
                                            data['name']?.toString() ??
                                                'No Name',
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
                                            data['phone']?.toString() ??
                                                'Not Provided',
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
                                            data['seatNumber']?.toString() ??
                                                'Not Assigned',
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
                                          text: 'Table Location',
                                          widget: Text(
                                            // data['side']?.toString() ??
                                            //     'Not Assigned',
                                            isBooking
                                                ? '${data['table'] ?? 'No Table'} - ${data['side'] ?? 'No Side'}'
                                                : data['table']?.toString() ??
                                                    'Not Assigned',
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
//           'Percentage of Invited\nGuests Approved:',
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
class _GuestsApproved extends StatelessWidget {
  const _GuestsApproved({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: getAcceptancePercentage(),
      builder: (context, snapshot) {
        final percentage = snapshot.data ?? 0.0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Percentage of Invited\nGuests Approved:',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
            Text(
              '(${percentage.toStringAsFixed(0)}%)',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
//   Stream<double> _getAcceptancePercentage() {
//     final acceptedStream = CombineLatestStream.combine2(
//       FirebaseFirestore.instance.collection('accepted_contacts').snapshots(),
//       FirebaseFirestore.instance.collection('manual_guest_accept').snapshots(),
//       (accepted, manual) => accepted.docs.length + manual.docs.length,
//     );

//     final totalStream = FirebaseFirestore.instance
//         .collection('guests')
//         .snapshots()
//         .map((snap) => snap.docs.length);

//     return CombineLatestStream.combine2(
//       acceptedStream,
//       totalStream,
//       (acceptedCount, totalCount) {
//         return totalCount > 0 ? (acceptedCount / totalCount) * 100 : 0.0;
//       },
//     );
//   }
// }
