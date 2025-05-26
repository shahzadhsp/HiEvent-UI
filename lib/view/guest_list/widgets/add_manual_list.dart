import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weddinghall/controllers/guests/add_manual_guests_controller.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/custom_text_form_field.dart';
import 'package:weddinghall/view/guest_list/guest_list_screen.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddManualList extends StatefulWidget {
  const AddManualList({super.key});
  @override
  State<AddManualList> createState() => _AddManualListState();
}

class _AddManualListState extends State<AddManualList> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final AddManualController _controller = Get.put(AddManualController());

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _inviteGuest() {
    if (_formKey.currentState!.validate()) {
      _controller.addGuest(
        nameController.text.trim(),
        phoneController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GuestListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Invite',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Guests Manualy',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Enter Name',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: nameController,
                hintText: 'entername',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              Text(
                'Enter phone',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: phoneController,
                hintText: 'enterphone',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 26.h),
              Obx(
                () =>
                    _controller.isLoading.value
                        ? CircularProgressIndicator()
                        : InkWell(
                          onTap: () {
                            _inviteGuest();
                          },
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 36.h,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.darkYellow,
                                border: Border.all(color: AppColors.darkYellow),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Invite',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  decorationColor: Colors.yellow,
                                  decorationThickness: 2,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// upload csv or excel file on the firebase

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  String? _fileName;
  double _uploadProgress = 0;
  bool _isUploading = false;

  Future<void> _uploadFile() async {
    try {
      // Pick file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'csv'],
      );

      if (result != null) {
        setState(() {
          _isUploading = true;
          _fileName = result.files.single.name;
        });
        File file = File(result.files.single.path!);
        // Create a reference to the Firebase Storage location
        final storageRef = FirebaseStorage.instance.ref().child(
          'files/${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}',
        );
        // Upload the file
        UploadTask uploadTask = storageRef.putFile(
          file,
          SettableMetadata(
            contentType:
                _fileName!.endsWith('.csv')
                    ? 'text/csv'
                    : 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          ),
        );

        // Listen to upload progress
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          setState(() {
            _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
          });
        });

        // Wait for upload to complete
        await uploadTask.whenComplete(() {});

        // Get download URL
        String downloadUrl = await storageRef.getDownloadURL();

        setState(() {
          _isUploading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File uploaded successfully!\nURL: $downloadUrl'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error uploading file: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Excel/CSV')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isUploading) ...[
              Text('Uploading $_fileName...'),
              SizedBox(height: 20),
              LinearProgressIndicator(value: _uploadProgress),
              SizedBox(height: 10),
              Text('${(_uploadProgress * 100).toStringAsFixed(1)}%'),
            ] else
              ElevatedButton(
                onPressed: _uploadFile,
                child: Text('Select Excel/CSV File'),
              ),
          ],
        ),
      ),
    );
  }
}
