// lib/controller/auth_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/auth/sign_in_screen.dart';
import 'package:weddinghall/view/auth/sign_up_screen.dart';
import 'package:weddinghall/view/home_screeen/home_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static AuthController instance = Get.find();

  // RX for reactive programming
  final Rx<User?> _user = Rx<User?>(FirebaseAuth.instance.currentUser);

  @override
  void onReady() {
    super.onReady();
    // Bind to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user.value = user;
    });
  }

  User? get user => _user.value;

  bool get isLoggedIn => user != null;

  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;
  final RxBool isPasswordShow = false.obs;

  Future<void> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      isLoading.value = true;
      // Create user
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = userCredential.user;

      if (user != null) {
        // Reference to Firestore collection
        final userCollection = FirebaseFirestore.instance.collection(
          'user_collection',
        );

        // Save user data with name
        await userCollection.doc(user.uid).set({
          'uid': user.uid,
          'name': name.trim(), // Added name field
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Navigate to sign-in screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Sign Up Failed',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.whiteColor,
        colorText: AppColors.primaryColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      // Navigate to home after successful sign in
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Sign In Failed',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.whiteColor,
        colorText: AppColors.primaryColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      isGoogleLoading.value = true;
      // Initialize Google Sign-In
      final GoogleSignIn googleSignIn = GoogleSignIn();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in
        return;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Tokens',
        );
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      await _auth.signInWithCredential(credential);
      // Navigate to home screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Google Sign In Failed',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.whiteColor,
        colorText: AppColors.primaryColor,
      );
      debugPrint('Google Sign-In Error: ${e.code} - ${e.message}');
    } catch (e) {
      Get.snackbar(
        'Google Sign In Failed',
        'An unexpected error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.whiteColor,
        colorText: AppColors.primaryColor,
      );
      debugPrint('Unexpected Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
