import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_colors.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Text(
              'HiEvent About Us',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 20.h),
            Text("""
Hi Event is a modern mobile app that helps people plan unforgettable events by connecting them with trusted vendors like DJs, photographers, makeup artists, venues, and more.

Our goal is to make event planning easy, fast, and inspiring. Whether it’s a wedding, engagement, birthday, or other celebration, users can discover top service providers, view photos, and contact vendors directly through Instagram or phone — all in one place.

Hi Event also helps couples plan ahead by letting them organize guest seating – tables and chairs – before the big day. This feature helps avoid stress and makes sure every guest has their place.

Hi Event brings together convenience, quality, and confidence for anyone planning a special day.

""", style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
