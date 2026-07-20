import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/knowledge_data.dart';
import '../models/knowledge_models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import '../widgets/nutrition_rainbow.dart';
import 'color_band_screen.dart';

/// The "Nutrition Rainbow" knowledge tab: an interactive rainbow that leads
/// into an encyclopedia of the compounds behind each color. Content follows
/// the language chosen in Settings (English or Vietnamese).
class RainbowHomeScreen extends StatelessWidget {
  const RainbowHomeScreen({super.key});

  void _openBand(BuildContext context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ColorBandScreen(band: bandById(id))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final en = context.watch<AppState>().isEnglish;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nutrition Rainbow', style: AppText.fredoka(size: 26)),
            const SizedBox(height: 4),
            Text(
                en
                    ? 'Explore the colors of the Rainbow…'
                    : 'Khám phá các màu của Cầu vồng…',
                style: AppText.body(size: 15, color: AppColors.muted)),
            const SizedBox(height: 4),
            Text(
                en
                    ? 'Tap a color band to explore its nutrients.'
                    : 'Chạm vào một dải màu để khám phá dưỡng chất.',
                style: AppText.body(size: 13, color: AppColors.muted2)),
            const SizedBox(height: 8),

            // ── Interactive rainbow (padded so it stays inside the frame) ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: InteractiveRainbow(onBandTap: (id) => _openBand(context, id)),
            ),
            const SizedBox(height: 18),

            // ── Color shortcut chips (accessible alternative to the arcs) ──
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final b in kBands)
                  _BandChip(
                    band: b,
                    label: en ? b.nameEn : b.nameVi,
                    onTap: () => _openBand(context, b.id),
                  ),
              ],
            ),
            const SizedBox(height: 22),

            // ── About this section ──
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppShadows.small,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('🌈', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(en ? 'Eat the rainbow' : 'Ăn đủ màu',
                          style: AppText.fredoka(
                              size: 16, weight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    en
                        ? 'Each color of fruit and vegetable carries its own '
                            'family of nutrients and plant compounds. Tap a '
                            'color to learn what it does, the science behind '
                            'it, and where to find it.'
                        : 'Mỗi màu rau củ mang một nhóm dưỡng chất riêng. Chạm '
                            'vào từng màu để hiểu công dụng, cơ sở khoa học và '
                            'nguồn thực phẩm.',
                    style: AppText.body(
                        size: 13.5, height: 1.6, color: AppColors.inkSoft),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BandChip extends StatelessWidget {
  const _BandChip(
      {required this.band, required this.label, required this.onTap});
  final RainbowBand band;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(colors: [band.color, band.colorLight]),
        boxShadow: AppShadows.glow(band.color, opacity: 0.28),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(label,
                style: AppText.fredoka(
                    size: 14, weight: FontWeight.w600, color: band.onColor)),
          ),
        ),
      ),
    );
  }
}
