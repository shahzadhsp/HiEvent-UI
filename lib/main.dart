import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weddinghall/controllers/auth/auth_controller.dart';
import 'package:weddinghall/firebase_options.dart';
import 'package:weddinghall/res/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/view/auth/sign_in_screen.dart';
import 'package:weddinghall/view/home_screeen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'shahzad12121',
  );
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
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: Obx(() {
            final authController = Get.find<AuthController>();
            return authController.isLoggedIn ? HomeScreen() : SignInScreen();
          }),
        );
      },
    );
  }
}
