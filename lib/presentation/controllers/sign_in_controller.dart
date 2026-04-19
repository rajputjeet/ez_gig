import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../routes/app_routes.dart';

class SignInController extends GetxController {
  final SignInUseCase _signInUseCase;
  SignInController(this._signInUseCase);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final error = RxnString();
  final obscurePassword = true.obs;
  final useEmail = false.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleInputMode() => useEmail.toggle();

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    error.value = null;
    try {
      final result = await _signInUseCase(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      result.fold(
        onSuccess: (_) => Get.offAllNamed(AppRoutes.main),
        onFailure: (msg) => error.value = msg,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void fillDemoCredentials() {
    usernameController.text = 'emilys';
    passwordController.text = 'emilyspass';
    useEmail.value = true;
  }
}
