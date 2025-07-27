import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kacha_test/app/app_colors.dart';
import 'package:kacha_test/app/app_strings.dart';
import 'package:kacha_test/app/app_text_styles.dart';
import 'package:kacha_test/features/auth/presentation/providers/auth_notifier_provider.dart';
import 'package:kacha_test/features/auth/presentation/providers/state/auth_state.dart';
import 'package:kacha_test/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:kacha_test/routes/app_router.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Text(
                  AppStrings.welcomeBack,
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.primaryLight,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppStrings.loginToContinue,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.secondaryLight,
                  ),
                ),
                SizedBox(height: 40.h),
                AuthTextField(
                  controller: _emailController,
                  label: AppStrings.email,
                  hint: AppStrings.enterYourEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.emailRequired;
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return AppStrings.invalidEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                AuthTextField(
                  controller: _passwordController,
                  label: AppStrings.password,
                  hint: AppStrings.enterYourPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.passwordRequired;
                    }
                    if (value.length < 6) {
                      return AppStrings.passwordTooShort;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                if (authState.status == AuthStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(AppStrings.login),
                    ),
                  ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: AppTextStyles.bodySmall,
                    ),
                    // TextButton(
                    //   onPressed: () => context.goNamed(Routes.register.name),
                    //   child: Text(
                    //     AppStrings.register,
                    //     style: AppTextStyles.bodySmall.copyWith(
                    //       color: AppColors.primaryLight,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authNotifierProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text.trim());
      context.pushNamed(Routes.dashboard.name);
    }
  }
}
