import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weddinghall/controllers/auth/auth_controller.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/auth/sign_up_screen.dart';
import 'package:weddinghall/view/common_widgets.dart/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await _authController.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0.r),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              Text(
                'Sign in',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Sign in to access an account and explore many things',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.greyColor),
              ),
              SizedBox(height: 40.h),
              Text(
                'Enter Email',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'Enter email',
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h),
              Text(
                'Enter Password',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
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
              SizedBox(height: 40.h),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _authController.isLoading.value ? null : _submitForm,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white, // Button background color
                      foregroundColor: Colors.white, // Text (and spinner) color
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child:
                        _authController.isLoading.value
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : Text(
                              'Sign in',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: AppColors.blackColor),
                            ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              Obx(() {
                return SizedBox(
                  width: double.maxFinite,
                  child: TextButton(
                    onPressed:
                        _authController.isGoogleLoading.value
                            ? null
                            : () => _authController.signInWithGoogle(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
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
                            : Text(
                              'Sign in with Google',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: AppColors.blackColor),
                            ),
                  ),
                );
              }),

              SizedBox(height: 24.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const SignUpScreen());
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
