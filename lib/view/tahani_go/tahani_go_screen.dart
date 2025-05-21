import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/tahani_go/record_screen.dart';

class TahaniGoScreen extends StatefulWidget {
  const TahaniGoScreen({super.key});

  @override
  State<TahaniGoScreen> createState() => _TahaniGoScreenState();
}

class _TahaniGoScreenState extends State<TahaniGoScreen> {
  PlatformFile? pickedFile;
  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File pickedFile = File(result.files.single.path!);
    } else {
      // User canceled the picker
      log('user cancel the pick image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Image.asset(AppAssets.nav),
        body: Column(
          children: [
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  TransltorWidget(image: AppAssets.translator, text: 'English'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'TahaniGo',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Image.asset(AppAssets.tahanigo2, height: 50.h, width: 50.w),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => _pickAndUploadVideo(context),
                      child: Container(
                        height: 100.h, // change 120
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAssets.image),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 40.h,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Center(
                                  child: Image.asset(AppAssets.uploadVideos2),
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // 2 container
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 120.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAssets.image2),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecordScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: AppColors.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.etCamera2,
                                      height: 30.h,
                                      width: 30.w,
                                      color: AppColors.whiteColor,
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      'Record Now',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () => _pickAndUploadImage(context),
                      child: Container(
                        height: 120.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAssets.image3),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 40.h,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'Choose From Gallery',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
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

  Future<void> _pickAndUploadImage(BuildContext context) async {
    try {
      // Pick image from gallery
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => const Center(child: CircularProgressIndicator()),
        );

        // Upload to Firebase Storage
        final String downloadUrl = await _uploadImageToFirebase(
          File(result.paths.first!),
        );

        // Close loading indicator
        Navigator.of(context).pop();

        // Use the downloadUrl as needed (save to database, display, etc.)
        print('Image uploaded to: $downloadUrl');

        // Show success message
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Image uploaded successfully!')));
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close loading indicator if open
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<String> _uploadImageToFirebase(File imageFile) async {
    try {
      // Initialize Firebase if not already done
      await Firebase.initializeApp();

      // Create a reference to the location you want to upload to in Firebase Storage
      final Reference storageReference = FirebaseStorage.instance.ref().child(
        'images/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      // Upload the file
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> _pickAndUploadVideo(BuildContext context) async {
    try {
      // Pick video file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => const Center(child: CircularProgressIndicator()),
        );

        // Upload to Firebase Storage
        final String downloadUrl = await _uploadVideoToFirebase(
          File(result.files.single.path!),
        );

        // Close loading indicator
        Navigator.of(context).pop();

        // Use the downloadUrl as needed
        print('Video uploaded to: $downloadUrl');

        // Show success message
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Video uploaded successfully!')));
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close loading indicator if open
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  // Function to upload video to Firebase Storage
  Future<String> _uploadVideoToFirebase(File videoFile) async {
    try {
      // Create a unique filename
      String fileName =
          'videos/${DateTime.now().millisecondsSinceEpoch}_${videoFile.path.split('/').last}';
      // Create reference to Firebase Storage location
      Reference storageReference = FirebaseStorage.instance.ref().child(
        fileName,
      );

      // Determine content type based on file extension
      String contentType = 'video/*'; // generic video type
      final extension = videoFile.path.split('.').last.toLowerCase();

      switch (extension) {
        case 'mp4':
          contentType = 'video/mp4';
          break;
        case 'mov':
          contentType = 'video/quicktime';
          break;
        case 'avi':
          contentType = 'video/x-msvideo';
          break;
        case 'mkv':
          contentType = 'video/x-matroska';
          break;
        case 'webm':
          contentType = 'video/webm';
          break;
      }

      // Upload the file with metadata
      UploadTask uploadTask = storageReference.putFile(
        videoFile,
        SettableMetadata(contentType: contentType),
      );

      // Show upload progress (optional)
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        log('Upload progress: $progress%');
      });

      // Wait for upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading video: $e');
      throw Exception('Failed to upload video: $e');
    }
  }
}
