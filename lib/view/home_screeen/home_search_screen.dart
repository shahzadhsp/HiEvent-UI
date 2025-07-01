import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/approved_list_screen/approved_list_screen.dart';
import 'package:weddinghall/view/declined_list/declined_list_screen.dart';
import 'package:weddinghall/view/event_cost/event_cost_screen.dart';
import 'package:weddinghall/view/event_cost_summary/event_cost_one.dart';
import 'package:weddinghall/view/guest_list/guest_list_screen.dart';
import 'package:weddinghall/view/pending_guests/pending_guest_screen.dart';
import 'package:weddinghall/view/sms/sms_screen.dart';
import 'package:weddinghall/view/tahani_go/tahani_go_screen.dart';
import 'package:weddinghall/view/testing/venue_selector.dart';
import 'package:weddinghall/view/vendors/vendors_screen.dart';

class HomeMenu {
  final String image;
  final String text;

  HomeMenu({required this.image, required this.text});
}

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  final List<HomeMenu> homeMenuList = [
    HomeMenu(image: AppAssets.hallLogo, text: 'Hall'),
    HomeMenu(image: AppAssets.sms, text: 'SMS'),
    HomeMenu(image: AppAssets.guestList, text: 'Guest List'),
    HomeMenu(image: AppAssets.approvedGuest, text: 'Approved\nGuest'),
    HomeMenu(image: AppAssets.declinedGuest, text: 'Declined\nGuest'),
    HomeMenu(image: AppAssets.pendingGuest, text: 'Pending\nGuest'),
    HomeMenu(image: AppAssets.event, text: 'Event 1'),
    HomeMenu(image: AppAssets.event, text: 'Event 2'),
    HomeMenu(image: AppAssets.event, text: 'Event 3'),
    HomeMenu(image: AppAssets.tahaniGo, text: 'TahaniGo'),
    HomeMenu(image: AppAssets.eventCost, text: 'Event Cost'),
    HomeMenu(image: AppAssets.vendors, text: 'Vendors'),
  ];

  List<HomeMenu> filteredList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = homeMenuList;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredList =
          homeMenuList
              .where((item) => item.text.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),

                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20.r),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.whiteColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Search Features',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall!.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search...',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        AppAssets.searchIcon2,
                        height: 16.h,
                        width: 16.w,
                        color: Colors.black,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return GestureDetector(
                      onTap: () {
                        if (item.text == 'Hall') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => VenueSelector()),
                          );
                        } else if (item.text == 'SMS') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SmsScreen()),
                          );
                        } else if (item.text == 'Guest List') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GuestListScreen(),
                            ),
                          );
                        } else if (item.text == 'Approved\nGuest') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ApprovedListScreen(),
                            ),
                          );
                        } else if (item.text == 'Declined\nGuest') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DeclinedListScreen(),
                            ),
                          );
                        } else if (item.text == 'Pending\nGuest') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PendingGuestScreen(),
                            ),
                          );
                        } else if (item.text == 'Event 1' ||
                            item.text == 'Event 2' ||
                            item.text == 'Event 3') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EventCostOne()),
                          );
                        } else if (item.text == 'TahaniGo') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => TahaniGoScreen()),
                          );
                        } else if (item.text == 'Event Cost') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EventCostScreen(),
                            ),
                          );
                        } else if (item.text == 'Vendors') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => VendorsScreen()),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(item.image, height: 30.h, width: 30.w),
                            SizedBox(height: 6.h),
                            Text(
                              item.text,
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
