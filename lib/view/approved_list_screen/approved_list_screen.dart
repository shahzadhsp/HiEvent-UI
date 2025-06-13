import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/utils/utills.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/guest_list/widgets/custom_list_tile.dart';

class ApprovedListScreen extends StatefulWidget {
  const ApprovedListScreen({super.key});

  @override
  State<ApprovedListScreen> createState() => _ApprovedListScreenState();
}

class _ApprovedListScreenState extends State<ApprovedListScreen> {
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
                  SizedBox(),
                  TransltorWidget(image: AppAssets.translator, text: 'English'),
                ],
              ),
            ),

            // Title Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Approved Guests',
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

            // Main Content (now scrollable)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Column(
                  children: [
                    _TotalApprovedGusts(),
                    _CustomDivider(),
                    SizedBox(height: 20.h),
                    _GuestsApproved(),
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
                    Expanded(
                      child: StreamBuilder<List<DocumentSnapshot>>(
                        stream: getCombinedAcceptedGuests(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(
                              child: Text("No accepted guests found"),
                            );
                          }

                          final acceptedGuests = snapshot.data!;

                          return ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: acceptedGuests.length,
                            itemBuilder: (context, index) {
                              final guest = acceptedGuests[index];
                              final data = guest.data() as Map<String, dynamic>;

                              // Extract seat number (trying multiple possible field names)
                              final seatNo =
                                  data['seatNo'] ??
                                  data['seat'] ??
                                  'Not assigned';
                              // Extract table number (trying multiple possible field names)
                              final tableNo =
                                  data['tableNo'] ??
                                  data['table'] ??
                                  'Not assigned';

                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffE2BE67),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      _buildListTile(
                                        context,
                                        AppAssets.greenCheckBox,
                                        'Name',
                                        data['name'] ?? 'No name',
                                      ),
                                      _buildListTile(
                                        context,
                                        AppAssets.phoneNumber2,
                                        'Phone Number',
                                        data['phone'] ??
                                            data['phones']?.first ??
                                            'No phone',
                                      ),
                                      _buildListTile(
                                        context,
                                        AppAssets.seatNo,
                                        'Seat No',
                                        seatNo
                                            .toString(), // Ensure it's a string
                                      ),

                                      _buildListTile(
                                        context,
                                        AppAssets.tableLocation,
                                        'Table Location',
                                        tableNo != 'Not assigned'
                                            ? 'Table ${tableNo.toString()}'
                                            : tableNo.toString(),
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

  Widget _buildListTile(
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

class _GuestsApproved extends StatelessWidget {
  const _GuestsApproved({super.key});

  // Helper method to calculate percentage
  Stream<double> _getApprovalPercentage() {
    return CombineLatestStream.combine2(
      FirebaseFirestore.instance.collection('accepted_contacts').snapshots(),
      FirebaseFirestore.instance.collection('manual_guest_accept').snapshots(),
      (QuerySnapshot acceptedContacts, QuerySnapshot manualAccept) {
        final totalAccepted =
            acceptedContacts.docs.length + manualAccept.docs.length;
        return totalAccepted.toDouble();
      },
    ).asyncMap((totalAccepted) async {
      // Get total guests count from other collections
      final guests =
          await FirebaseFirestore.instance.collection('guests').get();
      final imports =
          await FirebaseFirestore.instance
              .collection('imported_contacts')
              .get();
      final bookings =
          await FirebaseFirestore.instance.collection('booking').get();

      final totalGuests =
          guests.docs.length + imports.docs.length + bookings.docs.length;

      return totalGuests > 0 ? (totalAccepted / totalGuests) * 100 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: _getApprovalPercentage(),
      builder: (context, snapshot) {
        final percentage = snapshot.data ?? 0;
        final displayText = '(${percentage.toStringAsFixed(0)}%)';

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
              displayText,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: _getPercentageColor(percentage),
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper method to determine color based on percentage
  Color _getPercentageColor(double percentage) {
    if (percentage >= 75) return Colors.white;
    if (percentage >= 50) return Colors.white;
    if (percentage >= 25) return Colors.white;
    return Colors.white;
  }
}
