import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: AppColors.dark,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'EZGigs',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Get Started with EZGigs',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Connecting you to real opportunities,\nanytime anywhere',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(
                      icon: 'assets/icons/icon_google.svg',
                      onTap: controller.fillDemoCredentials,
                    ),
                    const SizedBox(width: 16),
                    _SocialButton(
                      icon: 'assets/icons/icon_apple.svg',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.border)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Or',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.border)),
                  ],
                ),
                const SizedBox(height: 28),
                Obx(
                  () => controller.useEmail.value
                      ? _buildEmailInput(context)
                      : _buildPhoneInput(context),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => GestureDetector(
                    onTap: controller.toggleInputMode,
                    child: Text(
                      controller.useEmail.value
                          ? 'Use Phone Number'
                          : 'Use Email ID',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Obx(() {
                  if (controller.error.value == null) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.logoutRed.withAlpha(20),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.logoutRed.withAlpha(60),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppColors.logoutRed,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              controller.error.value ?? '',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.logoutRed,
                                    fontSize: 13,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                Obx(() {
                  final loading = controller.isLoading.value;
                  return GestureDetector(
                    onTap: loading ? null : controller.signIn,
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: loading
                            ? AppColors.dark.withAlpha(150)
                            : AppColors.darkCard,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: loading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              'Verify',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                            ),
                    ),
                  );
                }),
                const SizedBox(height: 28),
                RichText(
                  text: TextSpan(
                    text: "Don't have account ",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textPrimary,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: AppColors.textHint,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Text(
                '🇮🇳',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontSize: 18),
              ),
              SizedBox(width: 4),
              Text(
                '+91',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: controller.usernameController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 14),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.phone_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
              hintText: '8543678940',
                counterText: ''
            ),
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller.usernameController,
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.person_outline,
              size: 18,
              color: AppColors.textSecondary,
            ),
            hintText: 'Username (try: emilys)',
          ),
          validator: (v) =>
              v == null || v.isEmpty ? 'Username is required' : null,
        ),
        const SizedBox(height: 12),
        Obx(
          () => TextFormField(
            controller: controller.passwordController,
            obscureText: controller.obscurePassword.value,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 14),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 18,
                color: AppColors.textSecondary,
              ),
              hintText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  controller.obscurePassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                onPressed: controller.togglePasswordVisibility,
              ),
            ),
            validator: (v) =>
                v == null || v.isEmpty ? 'Password is required' : null,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String? label;
  final String? icon;
  final VoidCallback onTap;

  const _SocialButton({this.label, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        alignment: Alignment.center,
        child: icon != null
            ? SvgPicture.asset(icon!, height: 24, width: 24)
            : Text(
                label!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4285F4),
                ),
              ),
      ),
    );
  }
}
