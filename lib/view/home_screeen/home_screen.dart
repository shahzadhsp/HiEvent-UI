import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/models/home_menu.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/declined_list/declined_list_screen.dart';
import 'package:weddinghall/view/event_cost/event_cost_screen.dart';
import 'package:weddinghall/view/guest_list/guest_list_screen.dart';
import 'package:weddinghall/view/home_screeen/hall/hall_screen.dart';
import 'package:weddinghall/view/pending_guests/pending_guest_screen.dart';
import 'package:weddinghall/view/sms/sms_screen.dart';
import 'package:weddinghall/view/tahani_go/record_screen.dart';
import 'package:weddinghall/view/tahani_go/tahani_go_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'search...',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: AppColors.blackColor),
                  suffixIcon: Icon(Icons.search),
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
                              builder: (context) => HallScreen(),
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
                  onPressed: () {},
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
                Padding(
                  padding: EdgeInsets.only(left: 0, right: 10.w),
                  child: Image.asset(
                    AppAssets.instagramLogo,
                    height: 30.h,
                    width: 30.w,
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
