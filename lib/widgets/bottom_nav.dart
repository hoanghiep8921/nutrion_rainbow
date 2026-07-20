import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

class NavItem {
  const NavItem(this.emoji, this.labelVi, this.labelEn);
  final String emoji;
  final String labelVi;
  final String labelEn;
}

const List<NavItem> kNavItems = [
  NavItem('🏠', 'Trang chủ', 'Home'),
  NavItem('🌈', 'Màu sắc', 'Colors'),
  NavItem('📖', 'Tri thức', 'Learn'),
  NavItem('✏️', 'Quiz', 'Quiz'),
  NavItem('🏆', 'Xếp hạng', 'Ranking'),
  NavItem('👤', 'Hồ sơ', 'Profile'),
];

/// The bottom navigation bar. Items share the width equally so it stays tidy
/// regardless of how many tabs there are. Labels follow the chosen language.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.activeColor = AppColors.green,
    this.english = false,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color activeColor;
  final bool english;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 8),
          child: Row(
            children: [
              for (var i = 0; i < kNavItems.length; i++)
                Expanded(
                  child: _NavButton(
                    item: kNavItems[i],
                    english: english,
                    active: i == currentIndex,
                    activeColor: activeColor,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.english,
    required this.active,
    required this.activeColor,
    required this.onTap,
  });

  final NavItem item;
  final bool english;
  final bool active;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? activeColor : AppColors.muted3;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 3),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                english ? item.labelEn : item.labelVi,
                maxLines: 1,
                style: AppText.body(
                  size: 11,
                  weight: active ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
