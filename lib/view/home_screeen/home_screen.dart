import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weddinghall/models/home_menu.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/about_us/about.dart';
import 'package:weddinghall/view/approved_list_screen/approved_list_screen.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/declined_list/declined_list_screen.dart';
import 'package:weddinghall/view/event_cost/event_cost_screen.dart';
import 'package:weddinghall/view/event_cost_summary/event_cost_one.dart';
import 'package:weddinghall/view/guest_list/guest_list_screen.dart';
import 'package:weddinghall/view/home_screeen/home_search_screen.dart';
import 'package:weddinghall/view/pending_guests/pending_guest_screen.dart';
import 'package:weddinghall/view/sms/sms_screen.dart';
import 'package:weddinghall/view/tahani_go/tahani_go_screen.dart';
import 'package:weddinghall/view/testing/venue_selector.dart';
import 'package:weddinghall/view/vendors/vendors_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _openInstagramProfile() async {
    final url =
        'https://www.instagram.com/matto_hun_yar?igsh=MW1yeTVhM2xqdGhneA==';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,

        body: Column(
          children: [
            SizedBox(height: 10.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TransltorWidget(image: AppAssets.translator, text: 'English'),
                  Text(
                    'Current Event: Event 1',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100.h,
              width: 100.w,
              child: Image.asset(AppAssets.appLogo),
            ),
            Text(
              'Wedding of Sarah & Daniel',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: AppColors.whiteColor),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeSearchScreen()),
                  );
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'search...',
                      hintStyle: Theme.of(context).textTheme.bodySmall!
                          .copyWith(color: AppColors.blackColor),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          AppAssets.searchIcon2,
                          height: 16.h,
                          width: 16.w,
                          color: AppColors.blackColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: homeMenuList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VenueSelector(),
                            ),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SmsScreen(),
                            ),
                          );
                        } else if (index == 9) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TahaniGoScreen(),
                            ),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GuestListScreen(),
                            ),
                          );
                        } else if (index == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeclinedListScreen(),
                            ),
                          );
                        } else if (index == 5) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PendingGuestScreen(),
                            ),
                          );
                        } else if (index == 10) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventCostScreen(),
                            ),
                          );
                        } else if (index == 11) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VendorsScreen(),
                            ),
                          );
                        } else if (index == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApprovedListScreen(),
                            ),
                          );
                        } else if (index == 6) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventCostOne(),
                            ),
                          );
                        } else if (index == 7) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventCostOne(),
                            ),
                          );
                        } else if (index == 8) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventCostOne(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                homeMenuList[index].image,
                                height:
                                    (index == 0 && index == 1) ? 30.h : 20.h,
                                width: (index == 0 && index == 1) ? 30.w : 20.w,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              homeMenuList[index].text,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: AppColors.blackColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    foregroundColor: AppColors.blackColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 36.h,
                    ),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'About Us',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    // _openInstagramProfile();
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 10.w),
                    child: Image.asset(
                      AppAssets.instagramLogo,
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
