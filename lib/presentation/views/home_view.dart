import 'package:cached_network_image/cached_network_image.dart';
import 'package:ez_gigs/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/view_state.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/entities/talent_entity.dart';
import '../controllers/home_controller.dart';
import '../widgets/error_retry_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/shimmer_box.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.dark,
          onRefresh: controller.fetchAll,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildStatsRow(),
              const SizedBox(height: 24),
              SectionHeader(title: 'Upcoming Games', onSeeAll: () {}),
              const SizedBox(height: 12),
              _buildGigsSection(),
              const SizedBox(height: 24),
              SectionHeader(
                title: 'Explore talent',
                subtitle: 'List of all the Videographers',
                onSeeAll: () {},
              ),
              const SizedBox(height: 12),
              _buildTalentSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.profile),
          child: const CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.border,
            child: Icon(
              Icons.person_outline,
              color: AppColors.textSecondary,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${controller.greeting}, johiee',
                    style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'You have ${controller.gigs.length} Gigz today',
                    style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/icon_bell.svg',
            height: 18,
            width: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: _StatCard(
                value: '${controller.pastGigCount.value}',
                label: 'Past Games',
                bgColor: AppColors.pinkCardBg,
                textColor: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                value: '${controller.gigs.length}',
                label: 'Upcoming Games',
                bgColor: AppColors.purpleCardBg,
                textColor: AppColors.textPrimary,
              ),
            ),
          ],
        ));
  }

  Widget _buildGigsSection() {
    return Obx(() {
      final state = controller.gigsState.value;

      if (state.isLoading) {
        return Column(
          children: List.generate(
            2,
                (_) => const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: ShimmerGigCard(),
            ),
          ),
        );
      }

      if (state.isError) {
        return ErrorRetryWidget(
          message: state.message!,
          onRetry: controller.fetchGigs,
        );
      }

      if (state.isSuccess) {
        final gigs = state.data!;
        if (gigs.isEmpty) return const SizedBox.shrink();
        return _CurrentGigCard(gig: gigs.first);
      }

      return const SizedBox.shrink();
    });
  }

  Widget _buildTalentSection() {
    return Obx(() {
      final state = controller.talentState.value;

      if (state.isLoading) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
          children: List.generate(4, (_) => const ShimmerTalentCard()),
        );
      }
      if (state.isError) {
        return ErrorRetryWidget(
          message: state.message!,
          onRetry: controller.fetchTalent,
        );
      }
      if(state.isSuccess) {
        final items = state.data?.take(6).toList();
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.19,
          children: items!.map((t) => _TalentCard(talent: t)).toList(),
        );
      }
      return const SizedBox.shrink();

    });
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color bgColor;
  final Color textColor;

  const _StatCard({
    required this.value,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: textColor.withAlpha(180)),
          ),
        ],
      ),
    );
  }
}

class _CurrentGigCard extends StatelessWidget {
  final GigEntity gig;

  const _CurrentGigCard({required this.gig});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gig.title,
                style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              _IconRow(icon: Icons.location_on_outlined, text: gig.location, white: true),
              const SizedBox(height: 6),
              _IconRow(
                icon: Icons.camera_alt_outlined,
                text: 'Photography by - ${gig.photographerName}',
                white: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _Chip(text: gig.date, dark: false),
                  const SizedBox(width: 8),
                  _Chip(text: gig.time, dark: false),
                ],
              ),
            ],
          ),
        ),
        if (gig.isCurrent)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.redBadge,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child:  Text(
                'Current',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _TalentCard extends StatelessWidget {
  final TalentEntity talent;

  const _TalentCard({required this.talent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: talent.image,
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const Spacer(),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              talent.rating.toString(),
                              style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    talent.name,
                    style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 105,
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8EE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Center(
              child: Text(
                'Exp. - ${talent.experienceYears} years',
                style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool white;

  const _IconRow({required this.icon, required this.text, required this.white});

  @override
  Widget build(BuildContext context) {
    final color = white ? Colors.white : AppColors.textSecondary;
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final bool dark;

  const _Chip({required this.text, required this.dark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: dark ? AppColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: dark ? null : Border.all(color: Colors.white30),
      ),
      child: Text(
        text,
        style:  Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.black,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class CornerBadgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - 30, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 30);
    path.lineTo(size.width, size.height);
    path.lineTo(30, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
