import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_theme.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: const Color(0xFFFAFAFA),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class ShimmerGigCard extends StatelessWidget {
  const ShimmerGigCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: const Color(0xFFFAFAFA),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 44, height: 44, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(height: 14, color: Colors.white, margin: const EdgeInsets.only(right: 60)),
              const SizedBox(height: 6),
              Container(height: 11, width: 100, color: Colors.white),
            ])),
          ]),
          const SizedBox(height: 12),
          Container(height: 11, color: Colors.white),
          const SizedBox(height: 6),
          Container(height: 11, width: 200, color: Colors.white),
        ]),
      ),
    );
  }
}

class ShimmerTalentCard extends StatelessWidget {
  const ShimmerTalentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: const Color(0xFFFAFAFA),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(height: 80, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 8),
          Container(height: 12, color: Colors.white),
          const SizedBox(height: 6),
          Container(height: 22, width: 80, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
        ]),
      ),
    );
  }
}
