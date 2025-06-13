import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/common_widgets.dart/transltor_widget.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  int _recordDuration = 0;
  String _recordStatus = "Ready to record";
  Timer? _timer;
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.closeRecorder();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _initRecorder() async {
    try {
      // Request microphone permission
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw 'Microphone permission not granted';
      }

      await _recorder.openRecorder();
      _recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
    } catch (e) {
      debugPrint('Error initializing recorder: $e');
      setState(() {
        _recordStatus = "Failed to initialize recorder";
      });
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    try {
      await _recorder.startRecorder(
        toFile: 'wedding_message.aac',
        codec: Codec.aacADTS,
      );

      setState(() {
        _isRecording = true;
        _recordDuration = 0;
        _recordStatus = "Recording...";
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() => _recordDuration++);
      });
    } catch (e) {
      debugPrint('Error starting recording: $e');
      setState(() {
        _recordStatus = "Error: Failed to start recording";
      });
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _recorder.stopRecorder();
      _timer?.cancel();

      setState(() {
        _isRecording = false;
        _recordStatus = "Recording saved";
      });

      // Here you can use the recorded file path (path) as needed
      debugPrint('Recording saved to: $path');
    } catch (e) {
      debugPrint('Error stopping recording: $e');
      setState(() {
        _recordStatus = "Error: Failed to stop recording";
      });
    }
  }

  String _formatDuration(int seconds) {
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Image.asset(AppAssets.nav),
        body: Column(
          children: [
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  TransltorWidget(image: AppAssets.translator, text: 'English'),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Text(
              'Wedding of Sarah & Daniel',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(color: AppColors.whiteColor),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                controller: _messageController,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 12.w,
                  ),
                  hintText: 'Record your message',
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                  fillColor: Colors.white,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Image.asset(
                      AppAssets.blackMic,
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Press the button to start recording your',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
            Text(
              'message',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: _toggleRecording,
              child: Image.asset(
                _isRecording ? AppAssets.playIcon : AppAssets.recordingIcon,
                height: 60.h,
                width: 60.w,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              _formatDuration(_recordDuration),
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: AppColors.whiteColor),
            ),
            SizedBox(height: 12.h),
            Text(
              _recordStatus,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
