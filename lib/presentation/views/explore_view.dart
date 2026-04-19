import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/gig_entity.dart';
import '../controllers/explore_controller.dart';
import '../widgets/error_retry_widget.dart';
import '../widgets/shimmer_box.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildSearchBar(context),
              const SizedBox(height: 16),
              Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore Gamehub',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 3),
               Text(
                'Explore games covered by videographers',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                     fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.add, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                'Game',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(Icons.search, size: 18, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      controller: controller.searchController,
      onChanged: controller.onSearchChanged,
      style:  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.dark, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textSecondary),
        hintText: 'Search games, clubs, locations...',
        hintStyle:  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13, color: AppColors.textHint),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, __) => const ShimmerGigCard(),
        );
      }
      if (controller.error.value != null) {
        return ErrorRetryWidget(
          message: controller.error.value!,
          onRetry: controller.fetchGigs,
        );
      }
      final gigs = controller.filteredGigs;
      if (gigs.isEmpty) {
        return  Center(
          child: Text('No games found.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
        );
      }
      return RefreshIndicator(
        color: AppColors.dark,
        onRefresh: controller.fetchGigs,
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: gigs.length,
          itemBuilder: (_, i) => _GigItem(gig: gigs[i], isLast: i == gigs.length - 1),
        ),
      );
    });
  }
}

class GigCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const cutX = 260.0;
    const cutY = 70.0;
    const r = 20.0; // 👈 slightly bigger for visible rounding

    final path = Path();

    // top-left
    path.moveTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);

    // top edge → cut start
    path.lineTo(cutX - r, 0);
    path.quadraticBezierTo(cutX, 0, cutX, r);

    // cut down
    path.lineTo(cutX, cutY - r);
    path.quadraticBezierTo(cutX, cutY, cutX + r, cutY);

    // cut → right edge
    path.lineTo(size.width - r, cutY);
    path.quadraticBezierTo(size.width, cutY, size.width, cutY + r);

    // right edge → bottom-right (rounded)
    path.lineTo(size.width, size.height - r);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );

    // bottom edge → bottom-left (rounded)
    path.lineTo(r, size.height);
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - r,
    );

    // back to start
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _GigItem extends StatelessWidget {
  final GigEntity gig;
  final bool isLast;

  const _GigItem({required this.gig, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ClipPath(
        clipper: GigCardClipper(),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(color: AppColors.grey),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.sports_soccer, size: 20, color: Colors.black54),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gig.title,
                          style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 13, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              gig.location,
                              style:  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...gig.clubs.map(
                (c) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.sports_soccer, size: 12, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          c,
                          style:  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _pill(gig.date,context),
                  const SizedBox(width: 6),
                  _pill(gig.time,context),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.pinkCardBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.black,
                          child: Text(
                            gig.photographerName[0],
                            style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          gig.photographerName,
                          style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pill(String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style:  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11.5,color: AppColors.textGrey)),
    );
  }
}
