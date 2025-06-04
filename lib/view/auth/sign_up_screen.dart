import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weddinghall/controllers/auth/auth_controller.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/auth/sign_in_screen.dart';
import 'package:weddinghall/view/common_widgets.dart/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthController _authController = Get.put(AuthController());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await _authController.signUpWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        context,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign up Successfully')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0.r),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              Text(
                'Sign up',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Register your account and explore many things',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.greyColor),
              ),
              SizedBox(height: 40.h),
              Text(
                'Enter Email',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'enter email',
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              Text(
                'Password',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => CustomTextFormField(
                  controller: _passwordController,
                  hintText: 'Enter password',
                  validator: _validatePassword,
                  obscureText: !_authController.isPasswordShow.value,
                  suffixIcon: Icon(
                    _authController.isPasswordShow.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  isPasswordShow: () {
                    _authController.isPasswordShow.value =
                        !_authController.isPasswordShow.value;
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Confirm Password',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: _confirmPasswordController,
                hintText: 'confirm password',
                validator: _validateConfirmPassword,
                obscureText: true,
              ),
              SizedBox(height: 40.h),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _authController.isLoading.value ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child:
                        _authController.isLoading.value
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Sign up',
                              style: TextStyle(fontSize: 16),
                            ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              // Obx(() {
              //   return SizedBox(
              //     width: double.maxFinite,
              //     child: TextButton(
              //       onPressed: () {
              //         _authController.isGoogleLoading.value
              //             ? const CircularProgressIndicator(color: Colors.white)
              //             : _authController.signInWithGoogle(context);
              //       },
              //       child: const Text(
              //         'Sign up with Google',
              //         style: TextStyle(fontSize: 16),
              //       ),
              //     ),
              //   );
              // }),
              Obx(() {
                return SizedBox(
                  width: double.maxFinite,
                  child: TextButton(
                    onPressed:
                        _authController.isGoogleLoading.value
                            ? null
                            : () => _authController.signInWithGoogle(context),
                    child:
                        _authController.isGoogleLoading.value
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Text(
                              'Sign up with Google',
                              style: TextStyle(fontSize: 16),
                            ),
                  ),
                );
              }),
              SizedBox(height: 24.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      child: const Text('Sign in'),
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
