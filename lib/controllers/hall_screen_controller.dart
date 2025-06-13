import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:developer';
import 'package:weddinghall/config/enums.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> saveBooking({
  required BuildContext context,
  required TableNumber selectedTable,
  required TableShape selectedShape,
  required String selectedSide,
  required int chairCount,
}) async {
  try {
    final booking = {
      'table': selectedTable.name,
      'shape': selectedShape.name,
      'side': selectedSide,
      'chairCount': chairCount,
      'timestamp': FieldValue.serverTimestamp(),
    };
    final String id = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection('booking').doc(id).set(booking);

    Get.snackbar(
      'Success',
      'Booking saved successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
    log('✅ Booking saved: $booking');
  } catch (e) {
    log('❌ Failed to save booking: $e');
    Get.snackbar(
      'Error',
      'Failed to save booking',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }
}

Future<void> sendWhatsAppMessage({
  required String phoneNumber,
  required String message,
}) async {
  final Uri url = Uri.parse(
    "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    // Show a user-friendly message
    throw Exception('WhatsApp not installed or URL could not be launched.');
  }
}
