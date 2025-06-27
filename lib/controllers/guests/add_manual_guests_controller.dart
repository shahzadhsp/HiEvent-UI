import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/guest_list/guest_list_screen.dart';

class AddManualController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final isLoading = false.obs;

  // Future<void> addGuest(String name, String phone, BuildContext context) async {
  //   String id = DateTime.now().microsecondsSinceEpoch.toString();
  //   try {
  //     isLoading(true);
  //     await _firestore.collection('guests').doc(id).set({
  //       'name': name,
  //       'phone': phone,
  //       'createdAt': FieldValue.serverTimestamp(),
  //     });

  //     Get.snackbar(
  //       'Success',
  //       'Guest added successfully',
  //       snackPosition: SnackPosition.TOP,
  //       duration: Duration(seconds: 3),
  //       backgroundColor: AppColors.whiteColor,
  //       colorText: AppColors.primaryColor,
  //       margin: EdgeInsets.all(16.r),
  //       borderRadius: 10,
  //       isDismissible: true,
  //     );

  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => GuestListScreen()),
  //     );

  //     // Delay to show snackbar before going back
  //     await Future.delayed(Duration(seconds: 3));
  //     Get.back();
  //   } catch (e) {
  //     // Show error snackbar
  //     Get.snackbar(
  //       'Error',
  //       'Failed to add guest: ${e.toString()}',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  Future<void> addGuest(String name, String phone, BuildContext context) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      isLoading(true);

      await _firestore.collection('guests').doc(id).set({
        'name': name,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });

      isLoading(false); // ✅ Reset loading BEFORE navigation

      Get.snackbar(
        'Success',
        'Guest added successfully',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.whiteColor,
        colorText: AppColors.primaryColor,
        margin: EdgeInsets.all(16.r),
        borderRadius: 10,
        isDismissible: true,
      );

      // Optional: wait for user to see the snackbar
      await Future.delayed(Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GuestListScreen()),
      );
    } catch (e) {
      isLoading(false); // ✅ Always reset in catch too

      Get.snackbar(
        'Error',
        'Failed to add guest: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.whiteColor,
        colorText: AppColors.primaryColor,
      );
    }
  }
}
