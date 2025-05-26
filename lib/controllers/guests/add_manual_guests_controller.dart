import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AddManualController extends GetxController {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final isLoading = false.obs;

  Future<void> addGuest(String name, String phone) async {
    try {
      isLoading(true);
      String key = _database.child('guests').push().key ?? '';
      await _database.child('guests').child(key).set({
        'name': name,
        'phone': phone,
        'createdAt': ServerValue.timestamp,
      });
      // Show snackbar before navigation
      Get.snackbar(
        'Success',
        'Guest added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      // Add slight delay before navigation to ensure snackbar shows
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
