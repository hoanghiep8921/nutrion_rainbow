# 🌈 Nutrition Rainbow

**Chạm vào sắc màu dinh dưỡng — sống khỏe hơn mỗi ngày.**

A gamified nutrition-learning mobile app built with **Flutter** for Android. Users
learn about nutrients through the six colours of food, take scored quizzes, earn
XP and streaks, unlock colours, and collect achievement badges.

This project implements the *Nutrition Rainbow* HTML design template as a real,
fully interactive Flutter app (not a static mockup).

---

## ✨ Features

- **8 screens**: Onboarding, Home, Nutrition Colors, Lesson Detail, Quiz, Quiz
  Result, Leaderboard, Profile.
- **6 full lessons** — Red · Lycopene, Orange · Beta-carotene, Yellow · Vitamin C,
  Green · Chlorophyll, Blue · Anthocyanin, Purple · Resveratrol — each with a
  description, example foods and a "Did you know?" fun fact.
- **30 quiz questions** (5 per colour) with a per-question timer, instant
  right/wrong feedback and scoring.
- **Gamification**: XP per correct answer, daily streak 🔥, star ratings, a daily
  "eat the rainbow" goal, and **20 achievement badges** that unlock automatically.
- **Progressive unlocking**: finish a colour's quiz to unlock the next.
- **Live leaderboard**: your XP is inserted among friends and re-ranked as you learn.
- **On-device persistence** — all progress is saved with `shared_preferences`, so
  it survives app restarts.
- Fully **Vietnamese** UI with English sub-labels, matching the template.

---

## 🎨 Design system

| Token | Value |
|-------|-------|
| Red | `#FF5A5F` · Orange `#FF9F45` · Yellow `#FFCE31` |
| Green | `#34C77B` · Blue `#3B9EFF` · Purple `#9B6DFF` |
| Background | `#F3EFE6` / `#FBF8F1` |
| Display font | **Fredoka** |
| Body font | **Be Vietnam Pro** |

Fonts are loaded via the `google_fonts` package (fetched once on first launch,
then cached).

---

## 🚀 Getting started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.19 or newer**
  (`flutter --version` to check).
- An Android device or emulator (Android Studio), or Chrome for a quick preview.

### Run it

The project ships the Dart source (`lib/`), tests **and a complete `android/`
platform folder** (Gradle config, manifest, MainActivity, launch theme, rainbow
launcher icons) — no `flutter create` step needed:

```bash
cd nutrition_rainbow

# 1. Fetch dependencies.
flutter pub get

# 2. Run on a connected Android device / emulator.
flutter run
```

> On the first build the Flutter tool writes `android/local.properties` and
> injects the Gradle wrapper automatically. Gradle is pinned to 8.9 with AGP
> 8.3.2 / Kotlin 1.9.24 (works on Flutter 3.19+). The launcher label is set in
> `android/app/src/main/AndroidManifest.xml` (`android:label="Nutrition Rainbow"`).

### Build an installable APK

```bash
flutter build apk --release
# output: build/app/outputs/flutter-apk/app-release.apk
```

> The release build is signed with the debug key so it installs out of the box.
> For Play Store publishing, add a real signing config in `android/app/build.gradle`.

### Run the tests

```bash
flutter test
```

The test suite verifies content integrity (6 colours, 30 well-formed questions,
unique badges) and the quiz star-rating logic.

---

## 🗂️ Project structure

```
lib/
├── main.dart                  # App entry, providers, routing
├── theme/
│   ├── app_colors.dart        # Rainbow palette + neutrals
│   ├── app_text.dart          # Fredoka / Be Vietnam Pro helpers
│   └── app_theme.dart         # Global ThemeData
├── models/
│   └── models.dart            # Color, Food, QuizQuestion, Badge, Leader
├── data/
│   ├── nutrition_data.dart    # All 6 colours: lessons + quizzes
│   ├── badges_data.dart       # 20-badge catalogue
│   └── leaderboard_data.dart  # Friend entries
├── state/
│   ├── app_state.dart         # Progress, XP, streak, badges + persistence
│   └── shell_controller.dart  # Bottom-nav tab controller
├── widgets/
│   ├── common.dart            # Buttons, shadows, floating animation
│   ├── rings.dart             # Rainbow ring, progress ring, progress bar
│   └── bottom_nav.dart        # 5-tab navigation bar
└── screens/
    ├── onboarding_screen.dart
    ├── main_shell.dart
    ├── home_screen.dart
    ├── colors_screen.dart
    ├── lesson_detail_screen.dart
    ├── quiz_screen.dart
    ├── quiz_result_screen.dart
    ├── leaderboard_screen.dart
    ├── profile_screen.dart
    └── quiz_hub_screen.dart
```

---

## 🧠 How progression works

- Opening a lesson awards **+20 XP** (once) and marks it studied.
- A quiz gives **+20 XP per correct answer**. Scoring **≥ 3/5** passes the colour,
  marks it complete, and **unlocks the next colour**.
- Badges are derived from your stats (colours completed, streak length, total XP,
  perfect scores, …) and unlock automatically — new ones are celebrated on the
  quiz-result screen.
- Everything is stored locally; use **Profile → Đặt lại tiến độ** to reset.

The app seeds a sensible starting state (Red/Orange/Yellow completed, Green
unlocked, streak 6, ~1,240 XP) so it looks alive on first launch, exactly like the
design mockup.

---

## 📌 Notes

- Learning content is educational and simplified for a general/young audience.
- Emoji render using the device's system emoji font.
- This is an MVP / portfolio project — a great base to extend with real accounts,
  a backend, notifications, or more colours and lessons.
