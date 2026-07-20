import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/badges_data.dart';
import '../data/nutrition_data.dart';
import '../models/models.dart';

/// Result returned after finishing a quiz, used to drive the result screen.
class QuizOutcome {
  QuizOutcome({
    required this.correct,
    required this.total,
    required this.xpEarned,
    required this.passed,
    required this.isNewBest,
    required this.newBadges,
  });

  final int correct;
  final int total;
  final int xpEarned;
  final bool passed;
  final bool isNewBest;
  final List<BadgeInfo> newBadges;

  /// Star rating out of 3 based on accuracy.
  int get stars {
    final ratio = total == 0 ? 0.0 : correct / total;
    if (ratio >= 0.95) return 3;
    if (ratio >= 0.6) return 2;
    if (ratio > 0) return 1;
    return 0;
  }
}

/// Central application state (progress, XP, streak, badges) with persistence.
class AppState extends ChangeNotifier {
  static const String _prefsKey = 'nutrition_rainbow_state_v1';

  /// Minimum correct answers (out of 5) needed to "pass" and unlock the next
  /// color.
  static const int passThreshold = 3;

  /// XP awarded per correct answer.
  static const int xpPerCorrect = 20;

  // ── Persisted fields ──────────────────────────────────────
  bool onboardingDone = false;
  String userName = 'Minh';
  int totalXp = 1240;
  int streak = 6;
  String language = 'en'; // UI language: 'en' (default) or 'vi'

  final Map<String, ColorStatus> _status = {};
  final Set<String> _lessonsRead = {};
  final Map<String, int> _bestScore = {}; // colorId -> best correct count
  final Map<String, int> _foodBestScore = {}; // food topicId -> best correct
  // Local leaderboard registry: userName -> recorded XP. Persists across
  // logins so everyone who has signed in on this device can be ranked.
  final Map<String, int> _leaderboard = {};
  DateTime? _lastActive;

  SharedPreferences? _prefs;

  // ── Loading / seeding ─────────────────────────────────────
  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs?.getString(_prefsKey);
    if (raw == null) {
      _seedDefaults();
      await _save();
      return;
    }
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      onboardingDone = map['onboardingDone'] as bool? ?? false;
      userName = map['userName'] as String? ?? 'Minh';
      totalXp = map['totalXp'] as int? ?? 0;
      streak = map['streak'] as int? ?? 0;
      language = map['language'] as String? ?? 'en';
      final lastStr = map['lastActive'] as String?;
      _lastActive = lastStr == null ? null : DateTime.tryParse(lastStr);

      _status.clear();
      final statusMap = (map['status'] as Map<String, dynamic>? ?? {});
      for (final entry in statusMap.entries) {
        _status[entry.key] = ColorStatus.values[entry.value as int];
      }
      _lessonsRead
        ..clear()
        ..addAll((map['lessonsRead'] as List<dynamic>? ?? []).cast<String>());
      _bestScore.clear();
      final scoreMap = (map['bestScore'] as Map<String, dynamic>? ?? {});
      for (final entry in scoreMap.entries) {
        _bestScore[entry.key] = entry.value as int;
      }
      _foodBestScore.clear();
      final foodMap = (map['foodBestScore'] as Map<String, dynamic>? ?? {});
      for (final entry in foodMap.entries) {
        _foodBestScore[entry.key] = entry.value as int;
      }
      _leaderboard.clear();
      final lbMap = (map['leaderboard'] as Map<String, dynamic>? ?? {});
      for (final entry in lbMap.entries) {
        _leaderboard[entry.key] = entry.value as int;
      }
    } catch (_) {
      _seedDefaults();
      await _save();
    }
    // Guarantee every color has a status.
    _ensureStatuses();
  }

  void _seedDefaults() {
    // A clean slate: no XP, no completed colors, only the first color
    // unlocked. Real progress is earned by passing quizzes after logging in.
    onboardingDone = false;
    userName = 'Minh';
    language = 'en';
    _freshStart();
  }

  void _ensureStatuses() {
    for (var i = 0; i < kColors.length; i++) {
      final id = kColors[i].id;
      if (!_status.containsKey(id)) {
        _status[id] = i == 0 ? ColorStatus.unlocked : ColorStatus.locked;
      }
    }
  }

  Future<void> _save() async {
    final prefs = _prefs;
    if (prefs == null) return;
    // Keep the local leaderboard in sync with the signed-in user's live XP
    // (only once they've actually logged in, so the demo seed never leaks in).
    if (onboardingDone && userName.trim().isNotEmpty) {
      _leaderboard[userName] = totalXp;
    }
    final map = <String, dynamic>{
      'onboardingDone': onboardingDone,
      'userName': userName,
      'totalXp': totalXp,
      'streak': streak,
      'language': language,
      'lastActive': _lastActive?.toIso8601String(),
      'status': _status.map((k, v) => MapEntry(k, v.index)),
      'lessonsRead': _lessonsRead.toList(),
      'bestScore': _bestScore,
      'foodBestScore': _foodBestScore,
      'leaderboard': _leaderboard,
    };
    await prefs.setString(_prefsKey, jsonEncode(map));
  }

  // ── Queries ───────────────────────────────────────────────
  ColorStatus statusOf(String colorId) =>
      _status[colorId] ?? ColorStatus.locked;

  bool isUnlocked(String colorId) => statusOf(colorId) != ColorStatus.locked;

  bool isCompleted(String colorId) =>
      statusOf(colorId) == ColorStatus.completed;

  bool lessonRead(String colorId) => _lessonsRead.contains(colorId);

  int bestScoreOf(String colorId) => _bestScore[colorId] ?? 0;

  int foodBestScoreOf(String topicId) => _foodBestScore[topicId] ?? 0;

  /// Progress fraction (0..1). A color only counts as "done" once its quiz
  /// has been passed — so nothing shows progress until you actually earn it.
  double progressOf(String colorId) => isCompleted(colorId) ? 1.0 : 0.0;

  int get completedCount =>
      kColors.where((c) => isCompleted(c.id)).length;

  int get colorsUnlockedCount =>
      kColors.where((c) => isUnlocked(c.id)).length;

  int get earnedBadgeCount =>
      kBadges.where((b) => isBadgeEarned(b.id)).length;

  int get totalBadgeCount => kBadges.length;

  /// The next color to study: the first unlocked-but-not-completed color.
  NutritionColorInfo? get nextToLearn {
    for (final c in kColors) {
      final s = statusOf(c.id);
      if (s == ColorStatus.unlocked) return c;
    }
    // Everything unlocked is complete — offer the first for review.
    return kColors.isNotEmpty ? kColors.first : null;
  }

  // ── Badge rules ───────────────────────────────────────────
  bool isBadgeEarned(String id) {
    switch (id) {
      case 'red_master':
        return isCompleted('red');
      case 'orange_master':
        return isCompleted('orange');
      case 'yellow_master':
        return isCompleted('yellow');
      case 'green_master':
        return isCompleted('green');
      case 'blue_master':
        return isCompleted('blue');
      case 'purple_master':
        return isCompleted('purple');
      case 'streak3':
        return streak >= 3;
      case 'streak7':
        return streak >= 7;
      case 'streak14':
        return streak >= 14;
      case 'streak30':
        return streak >= 30;
      case 'xp500':
        return totalXp >= 500;
      case 'xp1000':
        return totalXp >= 1000;
      case 'xp2500':
        return totalXp >= 2500;
      case 'xp5000':
        return totalXp >= 5000;
      case 'first_quiz':
        return _bestScore.isNotEmpty;
      case 'perfect':
        return kColors.any((c) => bestScoreOf(c.id) >= c.quiz.length);
      case 'quiz_master':
        return kColors.every((c) => _bestScore.containsKey(c.id));
      case 'rainbow':
        return completedCount == kColors.length;
      case 'explorer':
        return colorsUnlockedCount == kColors.length;
      case 'diligent':
        return _lessonsRead.length >= 3;
      default:
        return false;
    }
  }

  Set<String> get _earnedSet =>
      kBadges.where((b) => isBadgeEarned(b.id)).map((b) => b.id).toSet();

  // ── Leaderboard (local users only) ────────────────────────
  static const List<String> _avatars = [
    '🧑', '🧒', '👧', '👦', '🧕', '🧑‍🦱', '👩', '🧑‍🎓', '👨', '🙎', '🧑‍🍳', '🧑‍🌾',
  ];

  String _avatarFor(String name) =>
      _avatars[name.hashCode.abs() % _avatars.length];

  /// Everyone who has signed in on this device, ranked by XP. The current user
  /// always appears with their live XP.
  List<LeaderEntry> get leaderboard {
    final map = Map<String, int>.from(_leaderboard);
    if (onboardingDone && userName.trim().isNotEmpty) {
      map[userName] = totalXp;
    }
    final list = map.entries
        .map((e) => LeaderEntry(
              name: e.key == userName
                  ? '${e.key} ${isEnglish ? '(You)' : '(Bạn)'}'
                  : e.key,
              emoji: _avatarFor(e.key),
              xp: e.value,
              isYou: e.key == userName,
            ))
        .toList()
      ..sort((a, b) => b.xp.compareTo(a.xp));
    return list;
  }

  int get myRank {
    final list = leaderboard;
    for (var i = 0; i < list.length; i++) {
      if (list[i].isYou) return i + 1;
    }
    return list.length;
  }

  // ── Mutations ─────────────────────────────────────────────
  Future<void> completeOnboarding() async {
    onboardingDone = true;
    await _save();
    notifyListeners();
  }

  Future<void> setUserName(String name) async {
    userName = name.trim().isEmpty ? 'Bạn' : name.trim();
    await _save();
    notifyListeners();
  }

  bool get isEnglish => language == 'en';

  Future<void> setLanguage(String lang) async {
    if (lang != 'vi' && lang != 'en') return;
    language = lang;
    await _save();
    notifyListeners();
  }

  Future<void> markLessonRead(String colorId) async {
    final firstTime = !_lessonsRead.contains(colorId);
    _lessonsRead.add(colorId);
    if (firstTime) {
      totalXp += 20;
      _touchStreak();
    }
    await _save();
    notifyListeners();
  }

  /// Records a finished quiz and returns an outcome describing rewards.
  Future<QuizOutcome> finishQuiz(String colorId, int correct, int total) async {
    final before = _earnedSet;

    final prevBest = _bestScore[colorId] ?? 0;
    final isNewBest = correct > prevBest;
    if (isNewBest) _bestScore[colorId] = correct;

    final xpEarned = correct * xpPerCorrect;
    totalXp += xpEarned;

    _lessonsRead.add(colorId); // completing a quiz counts as having studied it
    final passed = correct >= passThreshold;
    if (passed) {
      _status[colorId] = ColorStatus.completed;
      _unlockNextAfter(colorId);
    }

    _touchStreak();

    final after = _earnedSet;
    final newBadgeIds = after.difference(before);
    final newBadges =
        kBadges.where((b) => newBadgeIds.contains(b.id)).toList();

    await _save();
    notifyListeners();

    return QuizOutcome(
      correct: correct,
      total: total,
      xpEarned: xpEarned,
      passed: passed,
      isNewBest: isNewBest,
      newBadges: newBadges,
    );
  }

  /// Records a finished food-group quiz. Awards XP and keeps a best score, but
  /// (unlike color quizzes) it does not affect the color unlock progression.
  Future<QuizOutcome> finishFoodQuiz(
      String topicId, int correct, int total) async {
    final before = _earnedSet;

    final prevBest = _foodBestScore[topicId] ?? 0;
    final isNewBest = correct > prevBest;
    if (isNewBest) _foodBestScore[topicId] = correct;

    final xpEarned = correct * xpPerCorrect;
    totalXp += xpEarned;
    _touchStreak();

    final after = _earnedSet;
    final newBadgeIds = after.difference(before);
    final newBadges =
        kBadges.where((b) => newBadgeIds.contains(b.id)).toList();

    await _save();
    notifyListeners();

    return QuizOutcome(
      correct: correct,
      total: total,
      xpEarned: xpEarned,
      passed: correct >= passThreshold,
      isNewBest: isNewBest,
      newBadges: newBadges,
    );
  }

  void _unlockNextAfter(String colorId) {
    final idx = kColors.indexWhere((c) => c.id == colorId);
    if (idx >= 0 && idx + 1 < kColors.length) {
      final nextId = kColors[idx + 1].id;
      if (statusOf(nextId) == ColorStatus.locked) {
        _status[nextId] = ColorStatus.unlocked;
      }
    }
  }

  void _touchStreak() {
    final today = _dateOnly(DateTime.now());
    if (_lastActive == null) {
      streak = 1;
    } else {
      final diff = today.difference(_lastActive!).inDays;
      if (diff == 0) {
        // same day — no change
      } else if (diff == 1) {
        streak += 1;
      } else {
        streak = 1;
      }
    }
    _lastActive = today;
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Wipes the current user's progress (keeps their name and their place on
  /// the leaderboard, now reset to 0). Used by the "reset" option in Profile.
  Future<void> resetProgress() async {
    _freshStart();
    onboardingDone = true; // keep the user inside the app
    await _save();
    notifyListeners();
  }

  // ── Login / logout ─────────────────────────────────────────
  /// A genuine "from scratch" state: no XP, no streak, only the first color
  /// unlocked, nothing studied. Used every time someone logs in.
  void _freshStart() {
    totalXp = 0;
    streak = 0;
    _lastActive = null;
    _status.clear();
    for (var i = 0; i < kColors.length; i++) {
      _status[kColors[i].id] =
          i == 0 ? ColorStatus.unlocked : ColorStatus.locked;
    }
    _lessonsRead.clear();
    _bestScore.clear();
    _foodBestScore.clear();
  }

  /// Logs in under [name]. Per the requested behaviour, every fresh login
  /// resets all progress back to the beginning.
  Future<void> loginAs(String name) async {
    userName = name.trim().isEmpty ? 'Bạn' : name.trim();
    _freshStart();
    onboardingDone = true;
    await _save();
    notifyListeners();
  }

  /// Signs the current user out (returns the app to the login screen).
  Future<void> logout() async {
    onboardingDone = false;
    await _save();
    notifyListeners();
  }
}
