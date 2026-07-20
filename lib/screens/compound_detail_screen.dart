import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/knowledge_models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import '../widgets/knowledge_header.dart';
import '../widgets/molecule.dart';
import '../widgets/source_link.dart';

/// Full encyclopedia page for a single compound: definition, benefits (each
/// with an optional clickable source), common food sources and — for the
/// anthocyanin family — its sub-types. Shows one language (chosen in Settings).
class CompoundDetailScreen extends StatelessWidget {
  const CompoundDetailScreen({
    super.key,
    required this.band,
    required this.compound,
  });

  final RainbowBand band;
  final Compound compound;

  /// A color that stays readable on white (yellow is too light).
  Color get _accent =>
      band.id == 'yellow' ? AppColors.yellowInk : band.color;

  @override
  Widget build(BuildContext context) {
    final en = context.watch<AppState>().isEnglish;
    final c = compound;
    return Scaffold(
      backgroundColor: AppColors.bgWarm,
      body: Column(
        children: [
          KnowledgeHeader(
            color: band.color,
            colorLight: band.colorLight,
            onColor: band.onColor,
            emoji: c.iconAsset == null ? c.emoji : null,
            iconAsset: c.iconAsset,
            eyebrow: en ? band.nameEn : band.nameVi,
            title: en ? c.name : c.nameVi,
            subtitle: en ? c.taglineEn : c.taglineVi,
            trailing: Pill(
              background: band.onColor == Colors.white
                  ? Colors.white.withOpacity(0.22)
                  : Colors.black.withOpacity(0.08),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(en ? band.nameEn : band.nameVi,
                  style: AppText.body(
                      size: 12.5,
                      weight: FontWeight.w700,
                      color: band.onColor)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Optional molecular structure (curcumin)
                  if (c.showCurcuminDiagram) ...[
                    _StructureCard(accent: _accent, en: en),
                    const SizedBox(height: 20),
                  ],

                  // ── Definition ──
                  _SectionTitle(
                      accent: _accent,
                      text: en ? 'Definition' : 'Định nghĩa'),
                  const SizedBox(height: 10),
                  Text(en ? c.definitionEn : c.definitionVi,
                      style: AppText.body(
                          size: 14.5, height: 1.62, color: AppColors.inkSoft)),
                  if (c.definitionSource != null) ...[
                    const SizedBox(height: 10),
                    SourceLink(source: c.definitionSource!, accent: _accent),
                  ],
                  const SizedBox(height: 24),

                  // ── Benefits ──
                  _SectionTitle(
                      accent: _accent, text: en ? 'Benefits' : 'Lợi ích'),
                  const SizedBox(height: 12),
                  for (var i = 0; i < c.benefits.length; i++) ...[
                    _BenefitCard(
                      index: i + 1,
                      accent: _accent,
                      title: en
                          ? c.benefits[i].titleEn
                          : c.benefits[i].titleVi,
                      body: en
                          ? c.benefits[i].bodyEn
                          : (c.benefits[i].bodyVi ?? c.benefits[i].bodyEn),
                      source: c.benefits[i].source,
                    ),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 14),

                  // ── Common sources ──
                  _SectionTitle(
                      accent: _accent,
                      text: en ? 'Common sources' : 'Nguồn thực phẩm'),
                  const SizedBox(height: 12),
                  if (c.sourceFoods.isNotEmpty) ...[
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (final f in c.sourceFoods) _FoodChip(food: f),
                      ],
                    ),
                    const SizedBox(height: 14),
                  ],
                  Text(en ? c.sourcesEn : c.sourcesVi,
                      style: AppText.body(
                          size: 14.5, height: 1.62, color: AppColors.inkSoft)),
                  if (c.sourcesSource != null) ...[
                    const SizedBox(height: 10),
                    SourceLink(source: c.sourcesSource!, accent: _accent),
                  ],

                  // ── Sub-types (anthocyanin family) ──
                  if (c.subtypes.isNotEmpty) ...[
                    const SizedBox(height: 26),
                    _SectionTitle(
                        accent: _accent,
                        text: en
                            ? 'Types of ${c.name.toLowerCase()}'
                            : 'Các loại ${c.nameVi.toLowerCase()}'),
                    const SizedBox(height: 12),
                    for (final s in c.subtypes) ...[
                      _SubtypeCard(accent: _accent, sub: s, en: en),
                      const SizedBox(height: 10),
                    ],
                  ],

                  const SizedBox(height: 22),
                  _Disclaimer(en: en),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StructureCard extends StatelessWidget {
  const _StructureCard({required this.accent, required this.en});
  final Color accent;
  final bool en;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.small,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(en ? 'Molecular structure' : 'Cấu trúc phân tử',
              style: AppText.body(
                  size: 12, weight: FontWeight.w700, color: accent)),
          const SizedBox(height: 12),
          CurcuminStructure(color: accent),
          const SizedBox(height: 8),
          Center(
            child: Text('Curcumin (C₂₁H₂₀O₆)',
                style: AppText.body(size: 12, color: AppColors.muted2)),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.accent, required this.text});
  final Color accent;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 6,
          height: 24,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Text(text, style: AppText.fredoka(size: 19, weight: FontWeight.w500)),
      ],
    );
  }
}

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({
    required this.index,
    required this.accent,
    required this.title,
    required this.body,
    this.source,
  });
  final int index;
  final Color accent;
  final String title;
  final String body;
  final Source? source;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.small,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text('$index',
                      style: AppText.fredoka(
                          size: 13, weight: FontWeight.w600, color: accent)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(title,
                      style: AppText.fredoka(
                          size: 15.5, weight: FontWeight.w500)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(body,
              style: AppText.body(
                  size: 13.8, height: 1.58, color: AppColors.inkSoft)),
          if (source != null) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: SourceLink(source: source!, accent: accent),
            ),
          ],
        ],
      ),
    );
  }
}

class _FoodChip extends StatelessWidget {
  const _FoodChip({required this.food});
  final FoodEmoji food;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppShadows.small,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          food.imageAsset != null
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(food.imageAsset!))
              : Text(food.emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 7),
          Text(food.label,
              style: AppText.body(
                  size: 12.5,
                  weight: FontWeight.w600,
                  color: AppColors.inkSoft)),
        ],
      ),
    );
  }
}

class _SubtypeCard extends StatelessWidget {
  const _SubtypeCard(
      {required this.accent, required this.sub, required this.en});
  final Color accent;
  final SubCompound sub;
  final bool en;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.small,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          iconColor: accent,
          collapsedIconColor: accent,
          title: Text(sub.name,
              style: AppText.fredoka(size: 15.5, weight: FontWeight.w500)),
          children: [
            _MiniBlock(
                accent: accent,
                label: en ? 'Definition' : 'Định nghĩa',
                text: en ? sub.definitionEn : sub.definitionVi),
            const SizedBox(height: 10),
            _MiniBlock(
                accent: accent,
                label: en ? 'Benefits' : 'Lợi ích',
                text: en ? sub.benefitsEn : sub.benefitsVi),
            const SizedBox(height: 10),
            _MiniBlock(
                accent: accent,
                label: en ? 'Sources' : 'Nguồn',
                text: en ? sub.sourcesEn : sub.sourcesVi),
          ],
        ),
      ),
    );
  }
}

class _MiniBlock extends StatelessWidget {
  const _MiniBlock(
      {required this.accent, required this.label, required this.text});
  final Color accent;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppText.body(
                size: 11.5, weight: FontWeight.w700, color: accent)),
        const SizedBox(height: 4),
        Text(text,
            style: AppText.body(
                size: 13, height: 1.5, color: AppColors.inkSoft)),
      ],
    );
  }
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer({required this.en});
  final bool en;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.chip,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ℹ️', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              en
                  ? 'For education only. This is not medical advice — consult a '
                      'professional before changing your diet or taking '
                      'supplements.'
                  : 'Chỉ mang tính giáo dục. Đây không phải lời khuyên y tế — '
                      'hãy hỏi ý kiến chuyên gia trước khi thay đổi chế độ ăn '
                      'hoặc dùng thực phẩm bổ sung.',
              style: AppText.body(
                  size: 12, height: 1.5, color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}
