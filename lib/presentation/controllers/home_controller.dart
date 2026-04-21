import 'package:get/get.dart';
import '../../core/utils/view_state.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/entities/talent_entity.dart';
import '../../domain/usecases/get_talent_usecase.dart';
import '../../domain/usecases/get_upcoming_gigs_usecase.dart';

class HomeController extends GetxController {
  final GetUpcomingGigsUseCase _getGigsUseCase;
  final GetTalentUseCase _getTalentUseCase;

  HomeController(this._getGigsUseCase, this._getTalentUseCase);


  final gigs = <GigEntity>[].obs;
  final gigsLoading = true.obs;
  final gigsError = RxnString();

  final talent = <TalentEntity>[].obs;
  final talentLoading = true.obs;
  final talentError = RxnString();

  final pastGigCount = 52.obs;

  final gigsState   = Rx<ViewState<List<GigEntity>>>(ViewState.initial());
  final talentState   = Rx<ViewState<List<TalentEntity>>>(ViewState.initial());

  String get greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() => Future.wait([fetchGigs(), fetchTalent()]);

  Future<void> fetchGigs() async {
    gigsLoading.value = true;
    gigsError.value = null;
    gigsState.value = ViewState.loading();
    try {
      final result = await _getGigsUseCase(limit: 5);
      result.fold(
        onSuccess: (data) => gigsState.value = ViewState.success(data),
            // gigs.assignAll(data),
        onFailure: (msg) => gigsState.value = ViewState.error(msg),
      );
    } finally {
      gigsLoading.value = false;
    }
  }

  Future<void> fetchTalent() async {
    talentLoading.value = true;
    talentError.value = null;
    try {
      final result = await _getTalentUseCase(limit: 6);
      result.fold(
        onSuccess: (data) => talentState.value = ViewState.success(data),
        onFailure: (msg) => talentState.value = ViewState.error(msg),
      );
    } finally {
      talentLoading.value = false;
    }
  }
}
