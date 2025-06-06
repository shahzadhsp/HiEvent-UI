// phone book

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsImportScreen extends StatefulWidget {
  @override
  _ContactsImportScreenState createState() => _ContactsImportScreenState();
}

class _ContactsImportScreenState extends State<ContactsImportScreen> {
  bool _isLoading = false;
  int _contactsImported = 0;
  List<Contact> _contacts = [];
  List<bool> _selectedContacts = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _fetchContacts() async {
    setState(() {
      _isLoading = true;
    });
    if (await Permission.contacts.request().isGranted) {
      try {
        final contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: false,
        );
        setState(() {
          _contacts = contacts;
          _selectedContacts = List<bool>.filled(contacts.length, false);
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error fetching contacts: $e')));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Contacts permission denied')));
    }
  }

  Future<void> _importSelectedContacts() async {
    setState(() {
      _isLoading = true;
      _contactsImported = 0;
    });

    try {
      final batch = _firestore.batch();
      final collectionRef = _firestore.collection('imported_contacts');
      int count = 0;
      for (int i = 0; i < _contacts.length; i++) {
        if (_selectedContacts[i] && _contacts[i].phones.isNotEmpty) {
          String id = DateTime.now().microsecondsSinceEpoch.toString();
          final docRef = collectionRef.doc(id);
          batch.set(docRef, {
            'name': _contacts[i].displayName,
            'phones': _contacts[i].phones.map((phone) => phone.number).toList(),
            'emails':
                _contacts[i].emails.map((email) => email.address).toList(),
            'importedAt': FieldValue.serverTimestamp(),
          });
          count++;
        }
      }

      await batch.commit();

      setState(() {
        _contactsImported = count;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully imported $count contacts to Firebase'),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error importing contacts: $e')));
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Contacts to Import')),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _contacts.length,
                      itemBuilder: (context, index) {
                        final contact = _contacts[index];
                        return CheckboxListTile(
                          title: Text(contact.displayName),
                          subtitle:
                              contact.phones.isNotEmpty
                                  ? Text(contact.phones.first.number)
                                  : Text('No phone number'),
                          value: _selectedContacts[index],
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedContacts[index] = value ?? false;
                            });
                          },
                          secondary:
                              contact.photo != null
                                  ? CircleAvatar(
                                    backgroundImage: MemoryImage(
                                      contact.photo!,
                                    ),
                                  )
                                  : CircleAvatar(
                                    child: Text(
                                      contact.displayName.isNotEmpty
                                          ? contact.displayName[0]
                                          : '?',
                                    ),
                                  ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selected: ${_selectedContacts.where((s) => s).length}',
                        ),
                        ElevatedButton(
                          onPressed: _importSelectedContacts,
                          child: Text('Import Selected'),
                        ),
                      ],
                    ),
                  ),
                  Text('Total imported: $_contactsImported'),
                ],
              ),
    );
  }
}
