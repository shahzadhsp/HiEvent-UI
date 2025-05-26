import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weddinghall/view/auth/sign_in_screen.dart';
import 'package:weddinghall/view/auth/sign_up_screen.dart';
import 'package:weddinghall/view/home_screeen/home_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;

          if (user != null) {
            return HomeScreen();
          }

          // Check navigation state
          final fromSignUp = Get.parameters['fromSignUp'] == 'true';
          return fromSignUp ? SignInScreen() : SignUpScreen();
        }

        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
