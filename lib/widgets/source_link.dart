import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/knowledge_models.dart';
import '../state/app_state.dart';
import '../theme/app_text.dart';

/// A small tappable citation chip. Tapping opens the study URL in the
/// device's browser (the mobile equivalent of the proposal's "hover to
/// preview, click to open" links).
class SourceLink extends StatelessWidget {
  const SourceLink({super.key, required this.source, required this.accent});

  final Source source;
  final Color accent;

  Future<void> _open(BuildContext context) async {
    final uri = Uri.parse(source.url);
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) _fail(context);
    } catch (_) {
      if (context.mounted) _fail(context);
    }
  }

  void _fail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Không mở được liên kết · ${source.url}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => _open(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: accent.withOpacity(0.10),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: accent.withOpacity(0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.menu_book_rounded, size: 13, color: accent),
            const SizedBox(width: 5),
            Text(
                '${context.watch<AppState>().isEnglish ? 'Source' : 'Nguồn'} · ${source.label}',
                style: AppText.body(
                    size: 11.5, weight: FontWeight.w600, color: accent)),
            const SizedBox(width: 4),
            Icon(Icons.open_in_new_rounded, size: 12, color: accent),
          ],
        ),
      ),
    );
  }
}
