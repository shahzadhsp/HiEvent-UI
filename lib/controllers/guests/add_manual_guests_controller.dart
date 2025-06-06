import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddManualController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final isLoading = false.obs;

  Future<void> addGuest(String name, String phone) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      isLoading(true);
      await _firestore
          .collection('guests')
          .doc(id)
          .set({
            'name': name,
            'phone': phone,
            'createdAt': FieldValue.serverTimestamp(),
          })
          .then((value) {
            Get.snackbar(
              'Success',
              'Guest added successfully',
              snackPosition: SnackPosition.BOTTOM,
            );
          });
      // Show success snackbar

      // Delay to show snackbar before going back
      await Future.delayed(Duration(milliseconds: 500));
      Get.back();
    } catch (e) {
      // Show error snackbar
      Get.snackbar(
        'Error',
        'Failed to add guest: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}
