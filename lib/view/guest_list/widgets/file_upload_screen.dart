// upload csv or excel file on the firebase
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  String? _fileName;
  double _uploadProgress = 0;
  bool _isUploading = false;

  Future<void> _uploadFile() async {
    try {
      // Pick file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'csv'],
      );

      if (result != null) {
        setState(() {
          _isUploading = true;
          _fileName = result.files.single.name;
        });
        File file = File(result.files.single.path!);
        // Create a reference to the Firebase Storage location
        final storageRef = FirebaseStorage.instance.ref().child(
          'files/${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}',
        );
        // Upload the file
        UploadTask uploadTask = storageRef.putFile(
          file,
          SettableMetadata(
            contentType:
                _fileName!.endsWith('.csv')
                    ? 'text/csv'
                    : 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          ),
        );

        // Listen to upload progress
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          setState(() {
            _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
          });
        });

        // Wait for upload to complete
        await uploadTask.whenComplete(() {});

        // Get download URL
        String downloadUrl = await storageRef.getDownloadURL();

        setState(() {
          _isUploading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File uploaded successfully!\nURL: $downloadUrl'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error uploading file: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Excel/CSV')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isUploading) ...[
              Text('Uploading $_fileName...'),
              SizedBox(height: 20),
              LinearProgressIndicator(value: _uploadProgress),
              SizedBox(height: 10),
              Text('${(_uploadProgress * 100).toStringAsFixed(1)}%'),
            ] else
              ElevatedButton(
                onPressed: _uploadFile,
                child: Text('Select Excel/CSV File'),
              ),
          ],
        ),
      ),
    );
  }
}
