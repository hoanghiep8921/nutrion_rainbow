import 'package:flutter/foundation.dart';

/// Controls the currently selected bottom-navigation tab. Provided at the app
/// root so that pushed routes (e.g. the quiz result) can jump to a tab.
class ShellController extends ChangeNotifier {
  int index = 0;

  static const int home = 0;
  static const int colors = 1;
  static const int rainbow = 2;
  static const int quiz = 3;
  static const int leaderboard = 4;
  static const int profile = 5;

  void goTo(int i) {
    if (i != index) {
      index = i;
      notifyListeners();
    }
  }
}
