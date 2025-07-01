import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/utils/utills.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/sms/widgets/custom_list_tile.dart';

class SmsScreen extends StatefulWidget {
  const SmsScreen({super.key});
  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  final String phoneNumber = '92302 7820436';
  final String email = 'mshahzadofficial89@gmail.com';

  Future<void> _openWhatsApp() async {
    final url = 'https://wa.me/$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'humas6971@gmail.com',
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
      path: '03027820436',
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

  final TextEditingController _messageController = TextEditingController();
  File? _selectedFile;
  bool _isLoading = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _sendFeedback() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please sign in first')));
      return;
    }

    if (_messageController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter your message')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      String? fileUrl;
      if (_selectedFile != null) {
        final fileName = 'feedback_${DateTime.now().millisecondsSinceEpoch}';
        final ref = FirebaseStorage.instance.ref().child('feedback/$fileName');
        await ref.putFile(_selectedFile!);
        fileUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('feedback').add({
        'userId': user.uid,
        'message': _messageController.text,
        'fileUrl': fileUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _messageController.clear();
      setState(() => _selectedFile = null);
      Get.snackbar(
        'Success',
        'Message sent successfully!',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.whiteColor,
        colorText: AppColors.primaryColor,
        margin: EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.whiteColor,
        colorText: AppColors.primaryColor,
        duration: Duration(seconds: 3),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.whiteColor,
                    ),
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
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.whiteColor),
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
                            StreamBuilder<List<DocumentSnapshot>>(
                              stream: getCombinedAcceptedGuests(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text('Loading...');
                                }
                                return Text(
                                  '${snapshot.data!.length} Accepted ',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            StreamBuilder<int>(
                              stream: getTotalGuestsCount(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error loading count');
                                }
                                if (!snapshot.hasData) {
                                  return Text('0');
                                }
                                return Text(
                                  '${snapshot.data}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
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
                child: GestureDetector(
                  onTap: _pickFile,
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
                          controller: _messageController,
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
                              if (_selectedFile != null)
                                Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Text(
                                    _selectedFile!.path.split('/').last,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
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
              ),

              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: TextButton(
                    onPressed: _isLoading ? null : _sendFeedback,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.darkYellow,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        side: BorderSide(
                          color:
                              _isLoading ? Colors.grey : AppColors.borderColor,
                          width: 1,
                        ),
                      ),
                      elevation: 2,
                      shadowColor: Colors.black12,
                    ),
                    child:
                        _isLoading
                            ? SizedBox(
                              width: 40.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : Text(
                              'Send Message',
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
