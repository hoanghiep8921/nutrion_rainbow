import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import '../widgets/rings.dart';
import 'main_shell.dart';

/// Simple name-based login. Signing in starts a fresh session (all progress
/// resets to the beginning) and drops the user into the app.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSubmit => _controller.text.trim().isNotEmpty && !_submitting;

  Future<void> _login() async {
    final name = _controller.text.trim();
    if (name.isEmpty || _submitting) return;
    setState(() => _submitting = true);
    await context.read<AppState>().loginAs(name);
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final en = context.watch<AppState>().isEnglish;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgSoft, AppColors.bgSoft2],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                const Center(
                  child: RainbowRing(
                    size: 150,
                    ringWidth: 18,
                    child: Text('🌈', style: TextStyle(fontSize: 58)),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text('Nutrition Rainbow',
                      style:
                          AppText.fredoka(size: 28, weight: FontWeight.w600)),
                ),
                const SizedBox(height: 6),
                Center(
                  child: Text(
                      en ? 'Sign in to start' : 'Đăng nhập để bắt đầu',
                      textAlign: TextAlign.center,
                      style: AppText.body(size: 14, color: AppColors.muted)),
                ),
                const SizedBox(height: 30),
                Text(en ? 'Your name' : 'Tên của bạn',
                    style: AppText.body(
                        size: 12.5,
                        weight: FontWeight.w700,
                        color: AppColors.muted)),
                const SizedBox(height: 8),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  onChanged: (_) => setState(() {}),
                  onSubmitted: (_) => _login(),
                  style: AppText.body(size: 16, color: AppColors.ink),
                  decoration: InputDecoration(
                    hintText: en ? 'e.g. Minh' : 'VD: Minh',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.lineDark),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.lineDark),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: AppColors.green, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: en ? 'Log in' : 'Đăng nhập',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF7A45), AppColors.red],
                  ),
                  glowColor: AppColors.red,
                  enabled: _canSubmit,
                  onTap: _login,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.tipBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('💡', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          en
                              ? 'Each sign-in starts fresh — XP, streak and '
                                  'badges are reset.'
                              : 'Mỗi lần đăng nhập, tiến độ sẽ bắt đầu lại từ '
                                  'đầu (XP, chuỗi ngày và huy hiệu được đặt lại).',
                          style: AppText.body(
                              size: 12,
                              height: 1.5,
                              color: AppColors.tipBody),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
