import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/usecases/get_all_gigs_usecase.dart';

class ExploreController extends GetxController {
  final GetAllGigsUseCase _getGigsUseCase;
  ExploreController(this._getGigsUseCase);

  final allGigs = <GigEntity>[].obs;
  final filteredGigs = <GigEntity>[].obs;
  final isLoading = true.obs;
  final error = RxnString();

  final searchController = TextEditingController();
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGigs();
    debounce(
      searchQuery,
      (_) => _applySearch(),
      time: const Duration(milliseconds: 300),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchGigs() async {
    isLoading.value = true;
    error.value = null;
    try {
      final result = await _getGigsUseCase(limit: 20);
      result.fold(
        onSuccess: (data) {
          allGigs.assignAll(data);
          filteredGigs.assignAll(data);
        },
        onFailure: (msg) => error.value = msg,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String query) => searchQuery.value = query;

  void _applySearch() {
    final q = searchQuery.value.toLowerCase();
    if (q.isEmpty) {
      filteredGigs.assignAll(allGigs);
    } else {
      filteredGigs.assignAll(
        allGigs.where((g) =>
            g.title.toLowerCase().contains(q) ||
            g.location.toLowerCase().contains(q) ||
            g.clubs.any((c) => c.toLowerCase().contains(q))),
      );
    }
  }
}
