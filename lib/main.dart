import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/main_shell.dart';
import 'screens/onboarding_screen.dart';
import 'state/about_state.dart';
import 'state/app_state.dart';
import 'state/shell_controller.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Never fetch fonts over the network at runtime, so the app works fully
  // offline without crashing. google_fonts will use bundled font files if
  // present, otherwise it falls back to the system font.
  GoogleFonts.config.allowRuntimeFetching = false;
  final state = AppState();
  await state.load();
  final about = AboutState();
  await about.load();
  runApp(NutritionRainbowApp(state: state, about: about));
}

class NutritionRainbowApp extends StatelessWidget {
  const NutritionRainbowApp({super.key, required this.state, required this.about});

  final AppState state;
  final AboutState about;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(value: state),
        ChangeNotifierProvider<AboutState>.value(value: about),
        ChangeNotifierProvider<ShellController>(create: (_) => ShellController()),
      ],
      child: MaterialApp(
        title: 'nutrition-rainbow',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: state.onboardingDone
            ? const MainShell()
            : const OnboardingScreen(),
      ),
    );
  }
}
