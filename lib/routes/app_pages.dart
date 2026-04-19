import 'package:ez_gigs/presentation/bindings/profile_binding.dart';
import 'package:ez_gigs/presentation/views/profile_view.dart';
import 'package:get/get.dart';
import '../presentation/bindings/main_binding.dart';
import '../presentation/bindings/sign_in_binding.dart';
import '../presentation/views/main_view.dart';
import '../presentation/views/sign_in_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
