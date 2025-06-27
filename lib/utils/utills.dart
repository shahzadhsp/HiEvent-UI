import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Combine both streams
Stream<List<DocumentSnapshot>> combinedGuestsStream() {
  return CombineLatestStream.combine2<
    List<DocumentSnapshot>,
    List<DocumentSnapshot>,
    List<DocumentSnapshot>
  >(getGuests(), importGuests(), (
    List<DocumentSnapshot> guests,
    List<DocumentSnapshot> imported,
  ) {
    final combined = [...guests, ...imported];

    // Optional: Sort by createdAt
    combined.sort((a, b) {
      final aTime = a['createdAt'] as Timestamp? ?? Timestamp.now();
      final bTime = b['createdAt'] as Timestamp? ?? Timestamp.now();
      return bTime.compareTo(aTime);
    });
    return combined;
  });
}

// Get guests stream
Stream<List<DocumentSnapshot>> getGuests() {
  return _firestore
      .collection('guests')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs);
}

// Get imported contacts stream
Stream<List<DocumentSnapshot>> importGuests() {
  return _firestore
      .collection('imported_contacts')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs);
}

class TestingPendingGuest extends StatefulWidget {
  const TestingPendingGuest({super.key});

  @override
  State<TestingPendingGuest> createState() => _TestingPendingGuestState();
}

class _TestingPendingGuestState extends State<TestingPendingGuest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Guests')),
      body: StreamBuilder<double>(
        stream: getAcceptancePercentage(),
        builder: (context, snapshot) {
          final percentage = snapshot.data ?? 0.0;
          return Container(
            decoration: BoxDecoration(
              color: Color(0xffE2BE67),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                Image.asset(AppAssets.greenCheckBox, height: 24.h, width: 24.w),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Acceptance Rate',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;app

// Get accepted guests from both collections
Stream<List<DocumentSnapshot>> getAcceptedGuests() {
  return CombineLatestStream.combine2(
    _firestore.collection('accepted_contacts').snapshots(),
    _firestore.collection('manual_guest_accept').snapshots(),
    (QuerySnapshot acceptedContacts, QuerySnapshot manualAccept) {
      return [...acceptedContacts.docs, ...manualAccept.docs];
    },
  );
}

// Get total guests count (from your existing collections)
Stream<int> getTotalGuestsCount() {
  return CombineLatestStream.combine3(
    _firestore.collection('guests').snapshots(),
    _firestore.collection('imported_contacts').snapshots(),
    _firestore.collection('booking').snapshots(),
    (QuerySnapshot guests, QuerySnapshot imports, QuerySnapshot bookings) {
      return guests.docs.length + imports.docs.length + bookings.docs.length;
    },
  );
}

// Calculate acceptance percentage
Stream<double> getAcceptancePercentage() {
  return CombineLatestStream.combine2(
    getAcceptedGuests(),
    getTotalGuestsCount(),
    (List<DocumentSnapshot> acceptedGuests, int totalGuests) {
      if (totalGuests == 0) return 0.0;
      return (acceptedGuests.length / totalGuests) * 100;
    },
  );
}

// get combined accepted guests
// 1. First, create a stream to get combined accepted guests
Stream<List<DocumentSnapshot>> getCombinedAcceptedGuests() {
  return CombineLatestStream.combine2(
    FirebaseFirestore.instance.collection('accepted_contacts').snapshots(),
    FirebaseFirestore.instance.collection('manual_guest_accept').snapshots(),
    (QuerySnapshot acceptedContacts, QuerySnapshot manualAccept) {
      return [...acceptedContacts.docs, ...manualAccept.docs];
    },
  );
}

String _generateSeatNumber() {
  final row = String.fromCharCode(65 + Random().nextInt(5)); // A-E
  final number = Random().nextInt(20) + 1; // 1-20
  return '$row-$number';
}

String _generateTableNumber() {
  final sections = ['Main Hall', 'Terrace', 'Garden'];
  return '${sections[Random().nextInt(sections.length)]} - Table ${Random().nextInt(15) + 1}';
}

// Stream<List<DocumentSnapshot>> getCombinedAcceptedGuests() {
//   return CombineLatestStream.combine2(
//     FirebaseFirestore.instance.collection('accepted_contacts').snapshots(),
//     FirebaseFirestore.instance.collection('manual_guest_accept').snapshots(),
//     (QuerySnapshot acceptedContacts, QuerySnapshot manualAccept) {
//       // Combine and ensure all documents have required fields
//       return [...acceptedContacts.docs, ...manualAccept.docs].map((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         return doc.reference
//             .collection('metadata')
//             .doc('assignment')
//             .set({
//               'seatNo': data['seatNo'] ?? _generateSeatNumber(),
//               'tableNo': data['tableNo'] ?? _generateTableNumber(),
//             }, SetOptions(merge: true))
//             .then((_) => doc);
//       }).toList();
//     },
//   ).asyncMap((futureList) => Future.wait(futureList));
// }

// 1. First create this acceptance service class
class GuestAcceptanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> acceptGuest({
    required String guestId,
    required String fromCollection,
    required Map<String, dynamic> guestData,
  }) async {
    try {
      // Generate seat and table numbers
      final seatNo = _generateSeatNumber();
      final tableNo = _generateTableNumber();

      // Add to accepted collection with consistent field names
      await _firestore.collection('accepted_contacts').doc(guestId).set({
        ...guestData,
        'seatNo': seatNo, // Consistent field name
        'tableNo': tableNo, // Consistent field name
        'acceptedAt': FieldValue.serverTimestamp(),
        'status': 'approved',
      }, SetOptions(merge: true));

      // Remove from original collection
      await _firestore.collection(fromCollection).doc(guestId).delete();
    } catch (e) {
      throw Exception('Failed to accept guest: $e');
    }
  }

  String _generateSeatNumber() {
    final row = String.fromCharCode(65 + Random().nextInt(5)); // A-E
    final number = Random().nextInt(20) + 1; // 1-20
    return '$row-$number';
  }

  String _generateTableNumber() {
    final sections = ['Main Hall', 'Terrace', 'Garden'];
    return '${sections[Random().nextInt(sections.length)]} - Table ${Random().nextInt(15) + 1}';
  }
}

// deleted guests list
class DeletedGuestsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DocumentSnapshot>> getCombinedDeletedGuests() {
    return CombineLatestStream.combine2(
      _firestore.collection('deleted_contacts').snapshots(),
      _firestore.collection('manual_guest_deleted').snapshots(),
      (QuerySnapshot deletedContacts, QuerySnapshot manualDeleted) {
        return [...deletedContacts.docs, ...manualDeleted.docs];
      },
    );
  }
}
