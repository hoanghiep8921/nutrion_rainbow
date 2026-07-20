import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/about_models.dart';

/// Holds the editable "About Us" content (mission / vision / values and the
/// list of founders) plus a simple admin gate. Content and the admin password
/// persist via SharedPreferences; the logged-in flag lives only for the
/// current session (the admin must sign in each launch).
class AboutState extends ChangeNotifier {
  static const String _key = 'nutrition_rainbow_about_v1';

  /// Default admin password. The admin can change it in the panel.
  static const String defaultPassword = 'admin123';

  String mission = '';
  String vision = '';
  String values = '';
  List<Founder> founders = [];
  String _password = defaultPassword;

  bool isAdmin = false; // session only — never persisted

  SharedPreferences? _prefs;

  // ── Loading / seeding ──────────────────────────────────────
  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs?.getString(_key);
    if (raw == null) {
      _seed();
      await _save();
      return;
    }
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      mission = map['mission'] as String? ?? '';
      vision = map['vision'] as String? ?? '';
      values = map['values'] as String? ?? '';
      _password = map['password'] as String? ?? defaultPassword;
      founders = ((map['founders'] as List<dynamic>?) ?? [])
          .map((e) => Founder.fromJson(e as Map<String, dynamic>))
          .toList();
      if (founders.isEmpty) _seed();
    } catch (_) {
      _seed();
      await _save();
    }
  }

  void _seed() {
    mission =
        "Creating a platform to raise awareness on foods' nutritional values "
        "and diversify your diet's color palette.";
    vision =
        'Pushing for a society that is more health-oriented and food literate.';
    values = 'Authenticity, intuitiveness, uniqueness.';
    _password = defaultPassword;
    founders = const [
      Founder(
        name: 'Phạm Quỳnh Chi',
        school: 'Hanoi - Amsterdam High School for the Gifted',
        email: 'quynhchuy2104@gmail.com',
        phone: '+84976449706',
        emoji: '👩‍🔬',
      ),
      Founder(
        name: 'Đỗ Đặng Trúc An',
        school: 'Hanoi - Amsterdam High School for the Gifted',
        email: 'trucan.dodang@gmail.com',
        phone: '+84974200309',
        emoji: '👩‍💻',
      ),
    ];
  }

  Future<void> _save() async {
    await _prefs?.setString(
      _key,
      jsonEncode({
        'mission': mission,
        'vision': vision,
        'values': values,
        'password': _password,
        'founders': founders.map((f) => f.toJson()).toList(),
      }),
    );
  }

  // ── Admin gate ─────────────────────────────────────────────
  bool get hasPassword => _password.isNotEmpty;

  bool login(String password) {
    if (password == _password) {
      isAdmin = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    isAdmin = false;
    notifyListeners();
  }

  Future<void> changePassword(String newPassword) async {
    if (newPassword.trim().isEmpty) return;
    _password = newPassword.trim();
    await _save();
    notifyListeners();
  }

  // ── Editing (admin only) ───────────────────────────────────
  Future<void> updateAbout({
    required String mission,
    required String vision,
    required String values,
  }) async {
    this.mission = mission.trim();
    this.vision = vision.trim();
    this.values = values.trim();
    await _save();
    notifyListeners();
  }

  /// Add a founder when [index] is null, otherwise replace the one at [index].
  Future<void> upsertFounder(int? index, Founder founder) async {
    if (index == null) {
      founders = [...founders, founder];
    } else if (index >= 0 && index < founders.length) {
      final copy = [...founders];
      copy[index] = founder;
      founders = copy;
    }
    await _save();
    notifyListeners();
  }

  Future<void> removeFounder(int index) async {
    if (index < 0 || index >= founders.length) return;
    final copy = [...founders]..removeAt(index);
    founders = copy;
    await _save();
    notifyListeners();
  }
}
