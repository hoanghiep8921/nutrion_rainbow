import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../state/shell_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/bottom_nav.dart';
import 'colors_screen.dart';
import 'home_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';
import 'quiz_hub_screen.dart';
import 'rainbow_home_screen.dart';

/// The main tabbed shell (Home / Colors / Rainbow / Quiz / Leaderboard /
/// Profile).
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  static const List<Widget> _tabs = [
    HomeScreen(),
    ColorsScreen(),
    RainbowHomeScreen(),
    QuizHubScreen(),
    LeaderboardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final shell = context.watch<ShellController>();
    final english = context.watch<AppState>().isEnglish;
    // The profile tab uses a purple accent; everything else is green.
    final accent =
        shell.index == ShellController.profile ? AppColors.purple : AppColors.green;
    return Scaffold(
      backgroundColor: AppColors.bgWarm,
      body: IndexedStack(index: shell.index, children: _tabs),
      bottomNavigationBar: AppBottomNav(
        currentIndex: shell.index,
        activeColor: accent,
        english: english,
        onTap: (i) => context.read<ShellController>().goTo(i),
      ),
    );
  }
}
