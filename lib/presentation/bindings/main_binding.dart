import 'package:get/get.dart';
import '../../domain/usecases/get_all_gigs_usecase.dart';
import '../../domain/usecases/get_talent_usecase.dart';
import '../../domain/usecases/get_upcoming_gigs_usecase.dart';
import '../controllers/explore_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetUpcomingGigsUseCase(Get.find()));
    Get.lazyPut(() => GetAllGigsUseCase(Get.find()));
    Get.lazyPut(() => GetTalentUseCase(Get.find()));

    Get.lazyPut(() => HomeController(Get.find(), Get.find()));
    Get.lazyPut(() => ExploreController(Get.find()));
    Get.lazyPut(() => ProfileController(Get.find()));
  }
}
