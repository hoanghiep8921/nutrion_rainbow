import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/knowledge_models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import '../widgets/knowledge_header.dart';
import 'compound_detail_screen.dart';

/// A color subtab (e.g. "Red"): shows the band intro and its compounds, in the
/// language chosen in Settings.
class ColorBandScreen extends StatelessWidget {
  const ColorBandScreen({super.key, required this.band});

  final RainbowBand band;

  @override
  Widget build(BuildContext context) {
    final en = context.watch<AppState>().isEnglish;
    return Scaffold(
      backgroundColor: AppColors.bgWarm,
      body: Column(
        children: [
          KnowledgeHeader(
            color: band.color,
            colorLight: band.colorLight,
            onColor: band.onColor,
            eyebrow: 'Nutrition Rainbow',
            title: en ? band.nameEn : band.nameVi,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(en ? band.introEn : band.introVi,
                      style: AppText.body(
                          size: 14.5, height: 1.6, color: AppColors.inkSoft)),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Text(en ? 'Key compounds' : 'Dưỡng chất tiêu biểu',
                          style: AppText.fredoka(
                              size: 17, weight: FontWeight.w500)),
                      const SizedBox(width: 8),
                      Pill(
                        background: band.color.withOpacity(0.14),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text('${band.compounds.length}',
                            style: AppText.body(
                                size: 12,
                                weight: FontWeight.w700,
                                color: band.color)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  for (final c in band.compounds) ...[
                    _CompoundCard(
                      band: band,
                      title: en ? c.name : c.nameVi,
                      subtitle: en ? c.taglineEn : c.taglineVi,
                      emoji: c.emoji,
                      iconAsset: c.iconAsset,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              CompoundDetailScreen(band: band, compound: c),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompoundCard extends StatelessWidget {
  const _CompoundCard({
    required this.band,
    required this.title,
    required this.subtitle,
    required this.emoji,
    this.iconAsset,
    required this.onTap,
  });

  final RainbowBand band;
  final String title;
  final String subtitle;
  final String emoji;
  final String? iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.small,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: band.color.withOpacity(0.12),
          highlightColor: band.color.withOpacity(0.06),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: band.color.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                      child: iconAsset != null
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(iconAsset!),
                            )
                          : Text(emoji,
                              style: const TextStyle(fontSize: 28))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: AppText.fredoka(
                              size: 17, weight: FontWeight.w500)),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: AppText.body(
                              size: 12.5, height: 1.4, color: AppColors.muted)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.chevron_right_rounded, color: band.color, size: 26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
