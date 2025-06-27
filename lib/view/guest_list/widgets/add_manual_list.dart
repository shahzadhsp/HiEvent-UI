import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weddinghall/controllers/guests/add_manual_guests_controller.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/custom_text_form_field.dart';

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

  @override
  void initState() {
    super.initState();
    Get.find<AddManualController>().isLoading.value = false;
  }

  void _inviteGuest() {
    if (_formKey.currentState!.validate()) {
      _controller.addGuest(
        nameController.text.trim(),
        phoneController.text.trim(),
        context,
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
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Guests Manualy',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Enter Name',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: 6.h),
              CustomTextFormField(
                controller: nameController,
                hintText: 'Entername',
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
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: 6.h),
              CustomTextFormField(
                controller: phoneController,
                hintText: 'Enterphone',
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
                        ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                            strokeWidth: 5,
                          ),
                        )
                        : InkWell(
                          borderRadius: BorderRadius.circular(20.r),
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
