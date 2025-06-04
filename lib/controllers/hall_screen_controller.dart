import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

    await FirebaseFirestore.instance.collection('booking').add(booking);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    log('✅ Booking saved: $booking');
  } catch (e) {
    log('❌ Failed to save booking: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to save booking'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

// Future<void> sendWhatsAppMessage({
//   required String phoneNumber, // Format: 92XXXXXXXXXX
//   required String message,
// }) async {
//   final url = Uri.parse(
//     "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
//   );

//   if (await canLaunchUrl(url)) {
//     await launchUrl(url, mode: LaunchMode.externalApplication);
//   } else {
//     throw 'Could not launch WhatsApp';
//   }
// }

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
