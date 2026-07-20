import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static String fmt(int xp) {
    if (xp >= 1000) {
      final v = xp / 1000;
      return '${v.toStringAsFixed(1)}k';
    }
    return '$xp';
  }

  @override
  Widget build(BuildContext context) {
    final en = context.watch<AppState>().isEnglish;
    final board = context.watch<AppState>().leaderboard;
    final top3 = board.take(3).toList();
    final rest = board.length > 3 ? board.sublist(3) : <LeaderEntry>[];

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(en ? 'Weekly ranking' : 'Xếp hạng tuần',
                style: AppText.fredoka(size: 26)),
            const SizedBox(height: 2),
            Text(en ? 'Top learners this week' : 'Top học viên chăm chỉ nhất',
                style: AppText.body(size: 14, color: AppColors.muted2)),
            const SizedBox(height: 24),
            _Podium(top3: top3),
            const SizedBox(height: 24),
            for (var i = 0; i < rest.length; i++) ...[
              _RankRow(rank: i + 4, entry: rest[i]),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _Podium extends StatelessWidget {
  const _Podium({required this.top3});
  final List<LeaderEntry> top3;

  static const List<List<Color>> _medals = [
    [Color(0xFFFFD23D), AppColors.orange], // gold (1st)
    [Color(0xFFC0C6CF), Color(0xFFE7EBF0)], // silver (2nd)
    [Color(0xFFE4A574), Color(0xFFF0C9A8)], // bronze (3rd)
  ];

  @override
  Widget build(BuildContext context) {
    if (top3.isEmpty) return const SizedBox.shrink();
    final first = top3[0];
    final second = top3.length > 1 ? top3[1] : null;
    final third = top3.length > 2 ? top3[2] : null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: second == null
              ? const SizedBox.shrink()
              : _PodiumSpot(entry: second, rank: 2, medal: _medals[1], pedestalPad: 10),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _PodiumSpot(
            entry: first,
            rank: 1,
            medal: _medals[0],
            pedestalPad: 16,
            crown: true,
            avatarSize: 66,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: third == null
              ? const SizedBox.shrink()
              : _PodiumSpot(entry: third, rank: 3, medal: _medals[2], pedestalPad: 6),
        ),
      ],
    );
  }
}

class _PodiumSpot extends StatelessWidget {
  const _PodiumSpot({
    required this.entry,
    required this.rank,
    required this.medal,
    required this.pedestalPad,
    this.crown = false,
    this.avatarSize = 56,
  });

  final LeaderEntry entry;
  final int rank;
  final List<Color> medal;
  final double pedestalPad;
  final bool crown;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    final isFirst = rank == 1;
    return Column(
      children: [
        if (crown) const Text('👑', style: TextStyle(fontSize: 24)),
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: medal),
            boxShadow: isFirst
                ? AppShadows.glow(AppColors.orange, opacity: 0.35)
                : null,
          ),
          child: Center(
              child: Text(entry.emoji,
                  style: TextStyle(fontSize: isFirst ? 30 : 26))),
        ),
        const SizedBox(height: 6),
        Text(entry.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.body(
                size: 13,
                weight: isFirst ? FontWeight.w700 : FontWeight.w600,
                color: AppColors.ink)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(4, pedestalPad, 4, 6),
          decoration: BoxDecoration(
            gradient: isFirst
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFD23D), AppColors.yellowDeep])
                : null,
            color: isFirst ? null : AppColors.lineDark,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: Column(
            children: [
              Text('$rank',
                  style: AppText.fredoka(
                      size: isFirst ? 22 : 18,
                      color: isFirst ? Colors.white : AppColors.muted2)),
              Text(LeaderboardScreen.fmt(entry.xp),
                  style: AppText.body(
                      size: 11,
                      color: isFirst ? Colors.white : AppColors.muted2)),
            ],
          ),
        ),
      ],
    );
  }
}

class _RankRow extends StatelessWidget {
  const _RankRow({required this.rank, required this.entry});
  final int rank;
  final LeaderEntry entry;

  @override
  Widget build(BuildContext context) {
    final you = entry.isYou;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: you
            ? const LinearGradient(colors: [AppColors.purple, AppColors.blue])
            : null,
        color: you ? null : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: you
            ? AppShadows.glow(AppColors.purple, opacity: 0.28)
            : AppShadows.small,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            child: Text('$rank',
                style: AppText.fredoka(
                    size: 16,
                    color: you ? Colors.white : AppColors.muted2)),
          ),
          const SizedBox(width: 8),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: you ? Colors.white.withOpacity(0.25) : AppColors.chip,
            ),
            child: Center(
                child: Text(entry.emoji, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(entry.name,
                style: AppText.body(
                    size: 15,
                    weight: you ? FontWeight.w700 : FontWeight.w500,
                    color: you ? Colors.white : AppColors.ink)),
          ),
          Text(LeaderboardScreen.fmt(entry.xp),
              style: AppText.body(
                  size: 14,
                  weight: FontWeight.w700,
                  color: you ? Colors.white : AppColors.streak)),
        ],
      ),
    );
  }
}
