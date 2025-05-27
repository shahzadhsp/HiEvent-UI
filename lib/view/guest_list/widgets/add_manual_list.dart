import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weddinghall/controllers/guests/add_manual_guests_controller.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/custom_text_form_field.dart';
import 'package:weddinghall/view/guest_list/guest_list_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
