import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:weddinghall/config/enums.dart';

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
