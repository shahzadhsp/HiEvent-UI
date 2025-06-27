import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorsScreen extends StatefulWidget {
  const VendorsScreen({super.key});

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  // Sample data for vendors
  final List<Map<String, dynamic>> vendorsList = [
    {'image': AppAssets.cameraMan, 'text': 'Photographer'},
    {'image': AppAssets.makeUp, 'text': 'Makeup'},
    {'image': AppAssets.selfie, 'text': 'Selfie'},
    {'image': AppAssets.flower, 'text': 'Florist'},
    {'image': AppAssets.clothing, 'text': 'Clothing'},
  ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  Future<void> _launchInstagram(String username) async {
    final Uri url = Uri.parse('https://www.instagram.com/$username');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomNavigationBar: Image.asset(AppAssets.nav),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Vendors',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Image.asset(
                    AppAssets.vendors,
                    height: 35.h,
                    width: 35.w,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(28.w, 0, 50.w, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete your vendor team',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Text(
                      'Find and book your vendors step by step',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        height: 3.5,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '2/9 Services Booked',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Stack(
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        Container(
                          width: 140.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: AppColors.darkYellow,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    // Firestore Vendors List
                    SizedBox(
                      height: 300.h,
                      child: StreamBuilder<QuerySnapshot>(
                        stream:
                            FirebaseFirestore.instance
                                .collection('vendors')
                                .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('No vendors found'),
                            );
                          }

                          return ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var vendor = snapshot.data!.docs[index];
                              Map<String, dynamic> data =
                                  vendor.data() as Map<String, dynamic>;
                              return Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                decoration: BoxDecoration(
                                  color: AppColors.darkYellow,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: ListTile(
                                  leading:
                                      data['imageUrl'] != null
                                          ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              data['imageUrl'],
                                            ),
                                          )
                                          : const CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
                                  title: Text(
                                    data['name'] ?? 'No Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data['category'] ?? 'No Category'),
                                      if (data['phone'] != null)
                                        GestureDetector(
                                          onTap:
                                              () =>
                                                  _makePhoneCall(data['phone']),
                                          child: Text(
                                            data['phone'],
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      // if (data['instagram'] != null)
                                      // GestureDetector(
                                      //   onTap:
                                      //       () => _launchInstagram(
                                      //         data['instagram'],
                                      //       ),
                                      //   child: Text(
                                      //     '@${data['instagram']}',
                                      //     style: TextStyle(
                                      //       color: Colors.blue,
                                      //       decoration:
                                      //           TextDecoration.underline,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 16.h),
                    Text(
                      'Top Vendors',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Top vendors horizontal list
                    SizedBox(
                      height: 98.h,
                      child: ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 220.w,
                            margin: EdgeInsets.only(right: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.asset(
                                    index == 0
                                        ? AppAssets.flower
                                        : AppAssets.clothing,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '0${index + 1}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        index == 0
                                            ? 'Lily Flowers'
                                            : 'Fashion House',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      Text(
                                        index == 0 ? 'Florist' : 'Clothing',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium!.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      'Vendors',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Vendors horizontal list
                    SizedBox(
                      height: 95.h,
                      child: ListView.builder(
                        itemCount: vendorsList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.asset(
                                    vendorsList[index]['image'],
                                    width: 70.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  vendorsList[index]['text'],
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
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

// test screen

class VendorsScreen2 extends StatelessWidget {
  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   if (await canLaunchUrl(launchUri)) {
  //     await launchUrl(launchUri);
  //   } else {
  //     throw 'Could not launch $launchUri';
  //   }
  // }

  // Future<void> _launchInstagram(String username) async {
  //   final Uri url = Uri.parse('https://www.instagram.com/$username');
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendors List')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('vendors').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No vendors found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var vendor = snapshot.data!.docs[index];
              Map<String, dynamic> data = vendor.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner Image
                    // if (data['bannerUrl'] != null)
                    //   SizedBox(
                    //     height: 150,
                    //     width: double.infinity,
                    //     child: Image.network(
                    //       data['bannerUrl'],
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Image and Name
                          Row(
                            children: [
                              if (data['imageUrl'] != null)
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    data['imageUrl'],
                                  ),
                                ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'] ?? 'No Name',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data['category'] ?? 'No Category',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Phone Number
                          if (data['phone'] != null)
                            GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.phone, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      data['phone'],
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // Instagram
                          if (data['instagram'] != null)
                            GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/instagram.png', // Add your Instagram icon asset
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '@${data['instagram']}',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // Created At
                          if (data['createdAt'] != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Joined: ${data['createdAt']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
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
              );
            },
          );
        },
      ),
    );
  }
}
