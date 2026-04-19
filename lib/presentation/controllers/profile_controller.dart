import 'package:get/get.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final AuthRepository _authRepository;
  ProfileController(this._authRepository);

  final RxBool notificationsEnabled = true.obs;

  Future<void> logout() async {
    await _authRepository.signOut();
    Get.offAllNamed(AppRoutes.signIn);
  }

  void toggleNotifications() => notificationsEnabled.toggle();
}
