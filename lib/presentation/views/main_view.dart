import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'home_view.dart';
import 'explore_view.dart';
import 'profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  final pages = const [
    HomeView(),
    ExploreView(),
    _PlaceholderView(Icons.calendar_month, 'Schedule'),
    _PlaceholderView(Icons.message_outlined, 'Messages'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: _FloatingNavBar(
          currentIndex: currentIndex,
          onTap: (i) => setState(() => currentIndex = i),
        ),
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      ('assets/icons/icon_home.svg', 'Home'),
      ('assets/icons/icon_explore.svg', 'Explore'),
      ('assets/icons/icon_calendar.svg', 'Schedule'),
      ('assets/icons/icon_message.svg', 'Messages'),
    ];

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withAlpha(80),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (i) {
          final (iconPath, label) = items[i];
          final isActive = currentIndex == i;

          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: isActive
                  ? const EdgeInsets.symmetric(horizontal: 18, vertical: 10)
                  : const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: isActive
                    ? null
                    : Border.all(color: Colors.white24, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isActive ? AppColors.dark : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.dark,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PlaceholderView(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColors.textHint),
            const SizedBox(height: 12),
            Text(label,
                style:  Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
