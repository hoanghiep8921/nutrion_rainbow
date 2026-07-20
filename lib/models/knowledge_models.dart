import 'package:flutter/material.dart';

/// A clickable source citation attached to a benefit or a section of the
/// nutrition encyclopedia. On mobile the URL opens in the external browser.
class Source {
  const Source(this.label, this.url);

  /// Short human label, e.g. "PubMed" or "ScienceDirect".
  final String label;

  /// Full https URL taken from the project proposal.
  final String url;
}

/// A small food example (emoji + label) used in the "common sources" strip.
///
/// [imageAsset], when set, is drawn instead of [emoji] (e.g. for foods with
/// no good emoji match).
class FoodEmoji {
  const FoodEmoji(this.emoji, this.label, {this.imageAsset});
  final String emoji;
  final String label;
  final String? imageAsset;
}

/// One documented health benefit of a compound.
///
/// English text is the primary content; [titleVi] / [bodyVi] provide a short
/// Vietnamese summary so the page is bilingual.
class Benefit {
  const Benefit({
    required this.titleEn,
    required this.titleVi,
    required this.bodyEn,
    this.bodyVi,
    this.source,
  });

  final String titleEn;
  final String titleVi;
  final String bodyEn;
  final String? bodyVi;
  final Source? source;
}

/// A sub-type of a compound — used for the anthocyanin family
/// (Petunidin, Malvidin, Procyanidins, Delphinidin).
class SubCompound {
  const SubCompound({
    required this.name,
    required this.definitionEn,
    required this.definitionVi,
    required this.benefitsEn,
    required this.benefitsVi,
    required this.sourcesEn,
    required this.sourcesVi,
  });

  final String name;
  final String definitionEn;
  final String definitionVi;
  final String benefitsEn;
  final String benefitsVi;
  final String sourcesEn;
  final String sourcesVi;
}

/// A nutrient / phytochemical compound inside a rainbow color band.
class Compound {
  const Compound({
    required this.id,
    required this.name,
    required this.nameVi,
    required this.emoji,
    required this.taglineEn,
    required this.taglineVi,
    required this.definitionEn,
    required this.definitionVi,
    required this.benefits,
    required this.sourcesEn,
    required this.sourcesVi,
    this.sourceFoods = const [],
    this.definitionSource,
    this.sourcesSource,
    this.subtypes = const [],
    this.showCurcuminDiagram = false,
    this.iconAsset,
  });

  final String id;
  final String name; // English name (page title)
  final String nameVi; // Vietnamese name
  final String emoji;

  /// When set, drawn instead of [emoji] on the compound's header (e.g. for
  /// compounds with no good emoji match).
  final String? iconAsset;
  final String taglineEn;
  final String taglineVi;
  final String definitionEn;
  final String definitionVi;
  final Source? definitionSource;
  final List<Benefit> benefits;
  final String sourcesEn;
  final String sourcesVi;
  final Source? sourcesSource;
  final List<FoodEmoji> sourceFoods;
  final List<SubCompound> subtypes;

  /// When true, the detail page draws the curcumin skeletal structure.
  final bool showCurcuminDiagram;
}

/// A color band of the interactive Nutrition Rainbow.
class RainbowBand {
  const RainbowBand({
    required this.id,
    required this.nameEn,
    required this.nameVi,
    required this.color,
    required this.colorLight,
    required this.onColor,
    required this.introEn,
    required this.introVi,
    required this.compounds,
  });

  final String id; // 'red', 'orange', ...
  final String nameEn;
  final String nameVi;
  final Color color;
  final Color colorLight;
  final Color onColor; // text color on top of [color]
  final String introEn;
  final String introVi;
  final List<Compound> compounds;
}
