import 'dart:developer';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/approved_list_screen/approved_list_screen.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';
import 'package:weddinghall/view/declined_list/declined_list_screen.dart';
import 'package:weddinghall/view/guest_list/widgets/add_manual_list.dart';
import 'package:weddinghall/view/guest_list/widgets/contacts_import_screen.dart';
import 'package:weddinghall/view/guest_list/widgets/custom_list_tile.dart';
import 'package:weddinghall/view/guest_list/widgets/file_upload_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weddinghall/view/pending_guests/pending_guest_screen.dart';

class GuestListScreen extends StatefulWidget {
  const GuestListScreen({super.key});
  @override
  State<GuestListScreen> createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Image.asset(AppAssets.nav),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    TransltorWidget(
                      image: AppAssets.translator,
                      text: 'English',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Guest List',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Image.asset(AppAssets.guestList2, height: 40.h, width: 40.w),
                ],
              ),
              SizedBox(height: 26.h),
              Text(
                'Wedding of Sarah & Danielo',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: 28.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        constraints: BoxConstraints(maxHeight: 33.h),
                        fillColor: AppColors.lightYellow,
                        hintText: 'search...',
                        hintStyle: Theme.of(context).textTheme.bodySmall!
                            .copyWith(color: AppColors.primaryColor),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            child: Image.asset(
                              AppAssets.searchIcon2,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactsImportScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.h,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightYellow,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Import from Phonebook',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.yellow,
                                  decorationThickness: 2,
                                  color: AppColors.darkYellow,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FileUploadScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.h,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightYellow,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Import from Excel',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.yellow,
                                  decorationThickness: 2,
                                  color: AppColors.darkYellow,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightYellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: CustomListTileWidget(
                              text: 'Name',
                              widget: CircleAvatar(
                                radius: 6.r,
                                backgroundColor: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColors.blackColor.withValues(alpha: 0.50),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: CustomListTileWidget(
                              text: 'Phone Number',
                              widget: CircleAvatar(
                                radius: 6.r,
                                backgroundColor: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColors.blackColor.withValues(alpha: 0.50),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: CustomListTileWidget(
                              text: 'Invite Status',
                              widget: PopupMenuButton<String>(
                                icon: Image.asset(
                                  AppAssets.iosDownArrow2,
                                  height: 14.h,
                                  width: 14.w,
                                ),
                                itemBuilder:
                                    (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'pending',
                                            child: Text('Pending'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'accepted',
                                            child: Text('Accepted'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'declined',
                                            child: Text('Declined'),
                                          ),
                                        ],
                                onSelected: (String value) {
                                  log('selected value $value');
                                  if (value == 'pending') {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => PendingGuestScreen(),
                                      ),
                                    );
                                  } else if (value == 'accepted') {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ApprovedListScreen(),
                                      ),
                                    );
                                  } else if (value == 'declined') {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => DeclinedListScreen(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Edit',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium!.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    SizedBox(width: 3.h),
                                    Image.asset(
                                      AppAssets.edit,
                                      height: 12.h,
                                      width: 12.w,
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Text(
                                      'delete',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium!.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    SizedBox(width: 3.h),
                                    Image.asset(
                                      AppAssets.deleteIcon,
                                      height: 12.h,
                                      width: 12.w,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddManualList(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.h,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.darkYellow,
                                border: Border.all(color: AppColors.darkYellow),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                '+ "Add Manually',
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
                        SizedBox(width: 18.w),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.h,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.darkYellow),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Save & Continue',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  decorationColor: Colors.yellow,
                                  decorationThickness: 2,
                                  color: AppColors.darkYellow,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PendingList extends StatefulWidget {
  const PendingList({super.key});

  @override
  State<PendingList> createState() => _PendingListState();
}

class _PendingListState extends State<PendingList> {
  // Reference to your Firebase Realtime Database
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child(
    'guests',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending List')),
      body: _buildPendingList(),
    );
  }

  Widget _buildPendingList() {
    // Using FirebaseAnimatedList for real-time updates
    return FirebaseAnimatedList(
      query: _databaseRef,
      itemBuilder: (context, snapshot, animation, index) {
        // Convert snapshot to Map
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        // Create ListTile for each item
        return ListTile(
          title: Text(data['name'] ?? 'No Name'),
          subtitle: Text(data['phone'] ?? 'No Phone'),
          trailing: const Icon(Icons.arrow_forward),
        );
      },
    );

    // Alternative if you don't need real-time updates:
    /*
    return FutureBuilder(
      future: _databaseRef.once(),
      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.value == null) {
          return const Center(child: Text('No pending items'));
        }

        Map<dynamic, dynamic> data = snapshot.data!.value as Map<dynamic, dynamic>;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            String key = data.keys.elementAt(index);
            return ListTile(
              title: Text(data[key]['name'] ?? 'No Name'),
              subtitle: Text(data[key]['phone'] ?? 'No Phone'),
            );
          },
        );
      },
    );
    */
  }
}

// class CombinedContact {
//   final String id;
//   final String name;
//   final String phone;
//   final String source; // 'firestore' or 'realtime'

//   CombinedContact({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.source,
//   });
// }

// class PendingList extends StatefulWidget {
//   const PendingList({super.key});

//   @override
//   State<PendingList> createState() => _PendingListState();
// }

// class _PendingListState extends State<PendingList> {
//   final CollectionReference _firestoreContacts = FirebaseFirestore.instance
//       .collection('imported_contacts');
//   final DatabaseReference _realtimeContacts = FirebaseDatabase.instance
//       .ref()
//       .child('guests');

//   List<CombinedContact> _combinedContacts = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadCombinedContacts();
//   }

//   Future<void> _loadCombinedContacts() async {
//     try {
//       // Fetch from Firestore
//       final firestoreSnapshot = await _firestoreContacts.get();
//       final firestoreContacts =
//           firestoreSnapshot.docs.map((doc) {
//             final data = doc.data() as Map<String, dynamic>;
//             return CombinedContact(
//               id: doc.id,
//               name: data['name'] ?? 'No Name',
//               phone: data['phone'] ?? 'No Phone',
//               source: 'firestore',
//             );
//           }).toList();

//       // Fetch from Realtime Database
//       final realtimeSnapshot = await _realtimeContacts.once();
//       final realtimeData =
//           realtimeSnapshot.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final realtimeContacts =
//           realtimeData.entries.map((entry) {
//             return CombinedContact(
//               id: entry.key.toString(),
//               name: entry.value['name'] ?? 'No Name',
//               phone: entry.value['phone'] ?? 'No Phone',
//               source: 'realtime',
//             );
//           }).toList();

//       setState(() {
//         _combinedContacts = [...firestoreContacts, ...realtimeContacts];
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       // Handle error
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Combined Contacts List')),
//       body:
//           _isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : _combinedContacts.isEmpty
//               ? const Center(child: Text('No contacts available'))
//               : _buildCombinedList(),
//     );
//   }

//   Widget _buildCombinedList() {
//     return ListView.builder(
//       itemCount: _combinedContacts.length,
//       itemBuilder: (context, index) {
//         final contact = _combinedContacts[index];
//         return ListTile(
//           title: Text(contact.name),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(contact.phone),
//               Text(
//                 'Source: ${contact.source}',
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//           trailing: const Icon(Icons.arrow_forward),
//         );
//       },
//     );
//   }
// }

class AcceptedList extends StatefulWidget {
  const AcceptedList({super.key});

  @override
  State<AcceptedList> createState() => _AcceptedListState();
}

class _AcceptedListState extends State<AcceptedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accepted List')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('No Data Found', style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class DeclinedList extends StatefulWidget {
  const DeclinedList({super.key});

  @override
  State<DeclinedList> createState() => _DeclinedListState();
}

class _DeclinedListState extends State<DeclinedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Declined List')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('No Data Found', style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
