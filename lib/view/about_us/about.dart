import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/res/app_assets.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            SizedBox(height: 30.h),
            InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: () => Navigator.pop(context),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
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
            ),
            SizedBox(height: 10.h),
            Center(
              child: Column(
                children: [
                  Image.asset(AppAssets.appLogo, height: 80.h, width: 80.w),
                  SizedBox(height: 10.h),
                  Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            // Content Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildFeatureCard(
                    icon: Icons.celebration,
                    title: "Your Celebration, Simplified",
                    description:
                        "Hi Event is a modern mobile app that helps people plan unforgettable events by connecting them with trusted vendors like DJs, photographers, makeup artists, venues, and more.",
                  ),
                  SizedBox(height: 20.h),
                  _buildFeatureCard(
                    icon: Icons.rocket_launch,
                    title: "Seamless Planning",
                    description:
                        "Our goal is to make event planning easy, fast, and inspiring. Whether it's a wedding, engagement, birthday, or other celebration, users can discover top service providers, view photos, and contact vendors directly through Instagram or phone — all in one place.",
                  ),
                  SizedBox(height: 20.h),
                  _buildFeatureCard(
                    icon: Icons.table_restaurant,
                    title: "Perfect Seating Arrangements",
                    description:
                        "Hi Event helps couples plan ahead by letting them organize guest seating – tables and chairs – before the big day. This feature helps avoid stress and makes sure every guest has their place.",
                  ),
                  SizedBox(height: 20.h),
                  _buildFeatureCard(
                    icon: Icons.star,
                    title: "Quality & Confidence",
                    description:
                        "Hi Event brings together convenience, quality, and confidence for anyone planning a special day.",
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: Text(
                      "Let's make your event unforgettable!",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
