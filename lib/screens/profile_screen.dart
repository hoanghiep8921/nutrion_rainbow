import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/badges_data.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import 'about_us_screen.dart';
import 'leaderboard_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  int _level(int xp) => (xp ~/ 200) + 1;

  Future<void> _editName(BuildContext context) async {
    final state = context.read<AppState>();
    final en = state.isEnglish;
    final controller = TextEditingController(text: state.userName);
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(en ? 'Rename' : 'Đổi tên',
            style: AppText.fredoka(size: 20)),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration:
              InputDecoration(hintText: en ? 'Your name' : 'Tên của bạn'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(en ? 'Cancel' : 'Hủy')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, controller.text),
              child: Text(en ? 'Save' : 'Lưu')),
        ],
      ),
    );
    if (name != null) await state.setUserName(name);
  }

  Future<void> _confirmReset(BuildContext context) async {
    final state = context.read<AppState>();
    final en = state.isEnglish;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(en ? 'Reset progress?' : 'Đặt lại tiến độ?',
            style: AppText.fredoka(size: 20)),
        content: Text(
            en
                ? 'All your XP, streak and badges will be reset.'
                : 'Toàn bộ XP, chuỗi ngày và huy hiệu sẽ được đặt lại về mặc định.',
            style: AppText.body(size: 14)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(en ? 'Cancel' : 'Hủy')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(en ? 'Reset' : 'Đặt lại',
                  style: AppText.body(
                      size: 14,
                      weight: FontWeight.w700,
                      color: AppColors.red))),
        ],
      ),
    );
    if (ok == true) await state.resetProgress();
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final en = context.read<AppState>().isEnglish;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(en ? 'Log out?' : 'Đăng xuất?',
            style: AppText.fredoka(size: 20)),
        content: Text(
            en
                ? 'Your next sign-in will start fresh — XP, streak and badges '
                    'will be reset.'
                : 'Lần đăng nhập tới sẽ bắt đầu lại từ đầu — XP, chuỗi ngày và '
                    'huy hiệu sẽ được đặt lại.',
            style: AppText.body(size: 14)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(en ? 'Cancel' : 'Hủy')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(en ? 'Log out' : 'Đăng xuất',
                  style: AppText.body(
                      size: 14,
                      weight: FontWeight.w700,
                      color: AppColors.red))),
        ],
      ),
    );
    if (ok == true) {
      await context.read<AppState>().logout();
      if (!context.mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Future<void> _pickLanguage(BuildContext context) async {
    final state = context.read<AppState>();
    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Ngôn ngữ · Language', style: AppText.fredoka(size: 20)),
        children: [
          _langOption(ctx, 'vi', 'Tiếng Việt', state.language),
          _langOption(ctx, 'en', 'English', state.language),
        ],
      ),
    );
    if (choice != null) await state.setLanguage(choice);
  }

  Widget _langOption(
      BuildContext ctx, String code, String label, String current) {
    final selected = code == current;
    return SimpleDialogOption(
      onPressed: () => Navigator.pop(ctx, code),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: selected ? AppColors.green : AppColors.muted3,
                size: 20),
            const SizedBox(width: 12),
            Text(label,
                style: AppText.body(
                    size: 15,
                    weight: selected ? FontWeight.w700 : FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final en = state.isEnglish;
    final earned = state.earnedBadgeCount;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Purple header ──
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.purple, AppColors.blue],
              ),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 26),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _editName(context),
                      child: Container(
                        width: 82,
                        height: 82,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.22),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.6), width: 3),
                        ),
                        child: const Center(
                            child: Text('🧑', style: TextStyle(fontSize: 40))),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(state.userName,
                        style: AppText.fredoka(size: 24, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(
                        en
                            ? 'Learner · Level ${_level(state.totalXp)} 🌱'
                            : 'Học viên · Level ${_level(state.totalXp)} 🌱',
                        style: AppText.body(
                            size: 13, color: Colors.white.withOpacity(0.9))),
                  ],
                ),
              ),
            ),
          ),

          // ── Stats ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Row(
              children: [
                Expanded(
                    child: _Stat(
                        value: '🔥 ${state.streak}',
                        label: en ? 'Streak' : 'Chuỗi ngày',
                        color: AppColors.streak)),
                const SizedBox(width: 10),
                Expanded(
                    child: _Stat(
                        value: LeaderboardScreen.fmt(state.totalXp),
                        label: en ? 'Total XP' : 'Tổng XP',
                        color: AppColors.green)),
                const SizedBox(width: 10),
                Expanded(
                    child: _Stat(
                        value: '$earned',
                        label: en ? 'Badges' : 'Huy hiệu',
                        color: AppColors.purple)),
              ],
            ),
          ),

          // ── Badge collection ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(en ? 'Badge collection' : 'Bộ sưu tập huy hiệu',
                    style: AppText.fredoka(size: 17, weight: FontWeight.w500)),
                Text('$earned / ${state.totalBadgeCount}',
                    style: AppText.body(
                        size: 13,
                        weight: FontWeight.w600,
                        color: AppColors.purple)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                for (final b in kBadges)
                  _BadgeTile(
                    badge: b,
                    earned: state.isBadgeEarned(b.id),
                    onTap: () => _showBadge(context, b, state.isBadgeEarned(b.id)),
                  ),
              ],
            ),
          ),

          // ── Settings ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: Column(
              children: [
                _SettingRow(
                    icon: Icons.language_rounded,
                    label: 'Ngôn ngữ · Language',
                    trailingText: state.isEnglish ? 'English' : 'Tiếng Việt',
                    onTap: () => _pickLanguage(context)),
                const SizedBox(height: 10),
                _SettingRow(
                    icon: Icons.groups_rounded,
                    label: en ? 'About Us' : 'Giới thiệu',
                    onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const AboutUsScreen()),
                        )),
                const SizedBox(height: 10),
                _SettingRow(
                    icon: Icons.edit_rounded,
                    label: en ? 'Rename' : 'Đổi tên',
                    onTap: () => _editName(context)),
                const SizedBox(height: 10),
                _SettingRow(
                    icon: Icons.restart_alt_rounded,
                    label: en ? 'Reset progress' : 'Đặt lại tiến độ',
                    danger: true,
                    onTap: () => _confirmReset(context)),
                const SizedBox(height: 10),
                _SettingRow(
                    icon: Icons.logout_rounded,
                    label: en ? 'Log out' : 'Đăng xuất',
                    danger: true,
                    onTap: () => _confirmLogout(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBadge(BuildContext context, BadgeInfo b, bool earned) {
    final en = context.read<AppState>().isEnglish;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: earned ? LinearGradient(colors: b.gradient) : null,
                color: earned ? null : AppColors.lineDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Text(earned ? b.emoji : '🔒',
                      style: const TextStyle(fontSize: 34))),
            ),
            const SizedBox(height: 14),
            Text(b.title,
                textAlign: TextAlign.center,
                style: AppText.fredoka(size: 18)),
            const SizedBox(height: 4),
            Text(b.subtitle,
                textAlign: TextAlign.center,
                style: AppText.body(size: 13, color: AppColors.muted2)),
            const SizedBox(height: 6),
            Text(
                earned
                    ? (en ? 'Unlocked ✓' : 'Đã mở khóa ✓')
                    : (en ? 'Locked' : 'Chưa mở khóa'),
                style: AppText.body(
                    size: 12,
                    weight: FontWeight.w700,
                    color: earned ? AppColors.green : AppColors.muted3)),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.color});
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.small,
      ),
      child: Column(
        children: [
          Text(value, style: AppText.fredoka(size: 20, color: color)),
          const SizedBox(height: 2),
          Text(label,
              textAlign: TextAlign.center,
              style: AppText.body(size: 11, color: AppColors.muted2)),
        ],
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile(
      {required this.badge, required this.earned, required this.onTap});
  final BadgeInfo badge;
  final bool earned;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: earned ? LinearGradient(colors: badge.gradient) : null,
          color: earned ? null : AppColors.lineDark,
          borderRadius: BorderRadius.circular(18),
          boxShadow:
              earned ? AppShadows.glow(badge.gradient.first, opacity: 0.28) : null,
        ),
        child: Center(
          child: Opacity(
            opacity: earned ? 1 : 0.5,
            child: Text(earned ? badge.emoji : '🔒',
                style: const TextStyle(fontSize: 28)),
          ),
        ),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
    this.trailingText,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.red : AppColors.inkSoft;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadows.small,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Text(label,
                style: AppText.body(
                    size: 15, weight: FontWeight.w600, color: color)),
            const Spacer(),
            if (trailingText != null) ...[
              Text(trailingText!,
                  style: AppText.body(
                      size: 13,
                      weight: FontWeight.w600,
                      color: AppColors.muted2)),
              const SizedBox(width: 6),
            ],
            Icon(Icons.chevron_right_rounded, color: AppColors.muted3),
          ],
        ),
      ),
    );
  }
}
