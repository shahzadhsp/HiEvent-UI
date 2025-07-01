import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weddinghall/controllers/auth/auth_controller.dart';
import 'package:weddinghall/data/notification_services.dart';
import 'package:weddinghall/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/view/auth/sign_in_screen.dart';
import 'package:weddinghall/view/home_screeen/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// 👇 Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("🔕 Background Message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // 👇 Register background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.initialize();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: Obx(() {
            final authController = Get.find<AuthController>();
            return authController.isLoggedIn ? HomeScreen() : SignInScreen();
          }),
        );
      },
    );
  }
}
