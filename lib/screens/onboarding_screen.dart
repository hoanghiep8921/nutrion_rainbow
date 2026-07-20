import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import '../widgets/rings.dart';
import 'login_screen.dart';

/// A swipeable 3-slide intro. The dots track the current page and you can
/// swipe or tap "Next" to move through it.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _SlideData {
  const _SlideData(this.emoji, this.title, this.subtitle, {this.first = false});
  final String emoji;
  final String title;
  final String subtitle;
  final bool first;
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pc = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  void _enter() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  List<_SlideData> _slides(bool en) => [
        _SlideData(
          '🌈',
          'Nutrition Rainbow',
          en
              ? 'Eat all the colors every day for a healthy body.'
              : 'Ăn đủ mọi màu mỗi ngày để cơ thể khỏe mạnh.',
          first: true,
        ),
        _SlideData(
          '🥦',
          en ? 'Learn by color' : 'Học theo màu',
          en
              ? 'Discover the nutrients behind every color of food — fruit, veg, meat and fish.'
              : 'Khám phá dưỡng chất sau mỗi màu thực phẩm — rau củ, quả, thịt và cá.',
        ),
        _SlideData(
          '🧠',
          en ? 'Play & progress' : 'Chơi & tiến bộ',
          en
              ? 'Take quizzes, earn XP and climb the leaderboard.'
              : 'Làm quiz, nhận XP và leo bảng xếp hạng.',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final en = context.watch<AppState>().isEnglish;
    final slides = _slides(en);
    final last = _page == slides.length - 1;

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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 12, 30, 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _enter,
                    child: Text(en ? 'Skip' : 'Bỏ qua',
                        style: AppText.body(
                            size: 14,
                            weight: FontWeight.w600,
                            color: AppColors.muted2)),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pc,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemCount: slides.length,
                    itemBuilder: (_, i) => _Slide(slide: slides[i]),
                  ),
                ),
                _Dots(count: slides.length, index: _page),
                const SizedBox(height: 26),
                PrimaryButton(
                  label: last
                      ? (en ? 'Get started' : 'Bắt đầu ngay')
                      : (en ? 'Next' : 'Tiếp tục'),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF7A45), AppColors.red],
                  ),
                  glowColor: AppColors.red,
                  onTap: last
                      ? _enter
                      : () => _pc.nextPage(
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.easeOut,
                          ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: _enter,
                    child: Text(
                      en
                          ? 'I already have an account · Sign in'
                          : 'Tôi đã có tài khoản · Đăng nhập',
                      style: AppText.body(
                        size: 14,
                        weight: FontWeight.w600,
                        color: AppColors.muted2,
                      ),
                    ),
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

class _Slide extends StatelessWidget {
  const _Slide({required this.slide});
  final _SlideData slide;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (slide.first)
          Bob(
            child: RainbowRing(
              size: 200,
              ringWidth: 24,
              child: Text(slide.emoji, style: const TextStyle(fontSize: 80)),
            ),
          )
        else
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: AppShadows.soft,
            ),
            child: Center(
                child: Text(slide.emoji, style: const TextStyle(fontSize: 80))),
          ),
        const SizedBox(height: 26),
        Text(slide.title,
            textAlign: TextAlign.center,
            style: AppText.fredoka(size: 30, weight: FontWeight.w600)),
        const SizedBox(height: 12),
        Text(slide.subtitle,
            textAlign: TextAlign.center,
            style: AppText.body(size: 16, height: 1.55, color: AppColors.muted)),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: i == index ? 26 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == index ? AppColors.green : const Color(0xFFE4DFD3),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ],
    );
  }
}
