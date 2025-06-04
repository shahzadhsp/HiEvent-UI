import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/sms/widgets/custom_list_tile.dart';

class SmsScreen extends StatefulWidget {
  const SmsScreen({super.key});
  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  final AppinioSocialShare appinioSocialShare = AppinioSocialShare();

  final String phoneNumber = '923044978989';
  final String email = 'mshahzadofficial89@gmail.com';

  Future<void> _openWhatsApp() async {
    final url = 'https://wa.me/$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  // open email
  // Future<void> _openEmail() async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //     query: 'subject=Support&body=Salam! Mujhe app se related madad chahiye.',
  //   );
  //   if (await canLaunchUrl(emailUri,)) {
  //     await launchUrl(emailUri);
  //   } else {
  //     throw 'Could not launch $emailUri';
  //   }
  // }

  // Future<void> _openEmail() async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: 'mshahzadofficial89@gmail.com',
  //     query: 'subject=Support&body=Salam! Mujhe app se related madad chahiye.',
  //   );

  //   if (await canLaunchUrl(emailUri)) {
  //     await launchUrl(emailUri, mode: LaunchMode.externalApplication);
  //   } else {
  //     debugPrint('Could not launch $emailUri');
  //   }
  // }
  Future<void> _openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'mshahzadofficial89@gmail.com',
      query: Uri.encodeFull(
        'subject=Support&body=Salam! Mujhe app se related madad chahiye.',
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $emailUri');
    }
  }

  // open sms inbox
  Future<void> _openSMS() async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '03044978989',
      queryParameters: <String, String>{
        'body': 'Salam! Mujhe app se related madad chahiye.',
      },
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $smsUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.white,
          child: Row(
            children: [
              Icon(Icons.add, color: Colors.brown[800]),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.brown),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Image.asset(AppAssets.sendSms, height: 20.h, width: 20.w),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.photo_camera, color: Colors.brown[800]),
              SizedBox(width: 8),
              Icon(Icons.mic, color: Colors.brown[800]),
            ],
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'SMS',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(width: 4.w),
                  Image.asset(
                    AppAssets.whiteSmsIcon,
                    height: 30.h,
                    width: 30.w,
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Text(
                'Wedding of Sarah & Daniel',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () async {
                  _openWhatsApp();
                },
                child: CustomListTile(
                  leadingImage: AppAssets.whatsappLogo,
                  text: 'Send on WhatsApp',
                  trailingImage: AppAssets.eyeContent,
                ),
              ),
              SizedBox(height: 12.h),
              InkWell(
                onTap: () {
                  _openEmail();
                },
                child: CustomListTile(
                  leadingImage: AppAssets.emailLogo,
                  text: 'Send on Email',
                  trailingImage: AppAssets.eyeContent,
                ),
              ),
              SizedBox(height: 14.h),
              InkWell(
                onTap: () {
                  _openSMS();
                },
                child: CustomListTile(
                  leadingImage: AppAssets.roundSSmsIcon,
                  text: 'Send on SMS',
                  trailingImage: AppAssets.eyeContent,
                ),
              ),
              SizedBox(height: 28.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 100.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: AppColors.darkYellow,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),
                        Text(
                          'Send on WhatsApp SMS Invite',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.greenCheckBox,
                              height: 16.h,
                              width: 16.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '10 Accepted',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Text(
                              ' 8',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 9.w),
                            Text(
                              'Pending',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  width: double.maxFinite,
                  height: 140.h,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      TextFormField(
                        maxLines: 9,

                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Type Your message here...",
                          hintStyle: TextStyle(color: AppColors.borderColor),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: 12,
                            left: 12,
                            right: 48,
                            bottom: 36,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppAssets.attachFile,
                              height: 36.h,
                              width: 36.w,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              "Attach file",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 8.w),
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
