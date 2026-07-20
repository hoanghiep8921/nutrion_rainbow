// Integration test: TỰ ĐỘNG thao tác các tính năng của Nutrition Rainbow
// để quay video demo / tài liệu hướng dẫn (không cần tay người).
//
// Chạy kèm script recording/record_auto.sh, hoặc chạy riêng:
//   flutter test integration_test/record_demo_test.dart \
//       --dart-define=FEATURE=all -d <device_id>
//
// FEATURE: all | 01_onboarding | 02_login | 03_home | 04_colors | 05_learn
//          | 06_quiz | 07_food_quiz | 08_leaderboard | 09_profile
//
// Mỗi bước in log "[DEMO] ..." ra console để dễ dò lỗi khi video bị đứng.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nutrition_rainbow/data/food_quiz_data.dart';
import 'package:nutrition_rainbow/data/knowledge_data.dart';
import 'package:nutrition_rainbow/data/nutrition_data.dart';
import 'package:nutrition_rainbow/main.dart' as app;
import 'package:nutrition_rainbow/models/models.dart';
import 'package:nutrition_rainbow/widgets/bottom_nav.dart';
import 'package:nutrition_rainbow/widgets/quiz_option.dart';

const String kFeature = String.fromEnvironment('FEATURE', defaultValue: 'all');

late WidgetTester t;

// ───────────────────────── Helpers ─────────────────────────

void log(String msg) => debugPrint('[DEMO] $msg');

/// Dừng [seconds] giây (app vẫn render bình thường) để video dễ xem.
Future<void> pause(double seconds) async {
  await Future<void>.delayed(
      Duration(milliseconds: (seconds * 1000).round()));
  await t.pump();
}

/// Chỉ nhận widget đang hiển thị thật (loại tab ẩn trong IndexedStack
/// và các route nằm dưới).
Finder visible(Finder f) => f.hitTestable();

void dumpScreen(String context) {
  final texts = find
      .byType(Text)
      .evaluate()
      .map((e) => (e.widget as Text).data)
      .whereType<String>()
      .where((s) => s.trim().isNotEmpty)
      .take(40)
      .join(' | ');
  log('!! $context. Text đang có trên màn hình: $texts');
}

/// Chờ tới khi [f] xuất hiện và bấm được (tối đa [timeout] giây).
Future<Finder> waitFor(Finder f, String what,
    {double timeout = 10}) async {
  final end =
      DateTime.now().add(Duration(milliseconds: (timeout * 1000).round()));
  while (!t.any(visible(f))) {
    if (DateTime.now().isAfter(end)) {
      dumpScreen('Chờ $timeout s vẫn không thấy "$what"');
      throw StateError('[DEMO] Không tìm thấy: $what');
    }
    await pause(0.25);
  }
  return visible(f).first;
}

bool exists(Finder f) => t.any(visible(f));

Future<void> tapText(String text, {double after = 1.2}) async {
  log('Bấm "$text"');
  await t.tap(await waitFor(find.text(text), '"$text"'));
  await t.pump();
  await pause(after);
}

Future<bool> maybeTapText(String text,
    {double after = 1.2, double wait = 3}) async {
  try {
    await t.tap(await waitFor(find.text(text), '"$text"', timeout: wait));
  } on StateError {
    log('Bỏ qua (không thấy "$text")');
    return false;
  }
  await t.pump();
  await pause(after);
  return true;
}

/// Chạm 1 tab ở bottom nav theo vị trí (0 Trang chủ … 5 Hồ sơ).
/// Lấy emoji trực tiếp từ kNavItems của app nên không sợ lệch ký tự.
Future<void> tapNav(int index, {double after = 1.4}) async {
  log('Mở tab ${kNavItems[index].labelVi}');
  final f = find.descendant(
    of: find.byType(AppBottomNav),
    matching: find.text(kNavItems[index].emoji),
  );
  await t.tap(await waitFor(f, 'tab ${kNavItems[index].labelVi}'));
  await t.pump();
  await pause(after);
}

/// Cuộn màn hình hiện tại xuống [dy] px (âm = cuộn lên), kéo chậm như tay.
Future<void> scrollDown(double dy,
    {double seconds = 1.1, double after = 0.9}) async {
  final s = visible(find.byType(Scrollable));
  if (!t.any(s)) return; // màn không cuộn được -> bỏ qua
  await t.timedDrag(s.first, Offset(0, -dy),
      Duration(milliseconds: (seconds * 1000).round()));
  await t.pump();
  await pause(after);
}

/// Quay lại màn trước: ưu tiên nút mũi tên trên UI, không có thì pop.
Future<void> popBack({double after = 1.0}) async {
  final back = visible(find.byIcon(Icons.arrow_back_rounded));
  if (t.any(back)) {
    log('Bấm nút quay lại');
    await t.tap(back.first);
  } else {
    log('Pop route');
    t.state<NavigatorState>(find.byType(Navigator).first).pop();
  }
  await t.pump();
  await pause(after);
}

/// Gõ tên vào ô đăng nhập (slow = gõ từng chữ cho giống người thật).
Future<void> typeName(String name, {bool slow = true}) async {
  await waitFor(find.byType(TextField), 'ô nhập tên');
  final field = find.byType(TextField).first;
  log('Gõ tên "$name"');
  if (slow) {
    for (var i = 1; i <= name.length; i++) {
      await t.enterText(field, name.substring(0, i));
      await pause(0.25);
    }
  } else {
    await t.enterText(field, name);
    await pause(0.3);
  }
}

/// Đưa app về màn chính, bất kể đang ở onboarding / đăng nhập / màn chính.
Future<void> introFast() async {
  log('Intro nhanh: vào màn chính');
  await pause(0.8);
  if (exists(find.byType(AppBottomNav))) {
    log('Đã ở màn chính, bỏ qua intro');
    return;
  }
  if (exists(find.text('Skip'))) await tapText('Skip', after: 0.9);
  if (exists(find.byType(TextField))) {
    await typeName('Minh', slow: false);
    await tapText('Log in', after: 1.8);
  }
  await waitFor(find.byType(AppBottomNav), 'màn chính (bottom nav)');
  await pause(1.0);
}

// ───────────────────────── Từng tính năng ─────────────────────────

Future<void> demoOnboarding() async {
  log('--- Onboarding ---');
  await waitFor(find.text('Skip'), 'màn onboarding (nút Skip)');
  await pause(2.5); // slide 1
  await tapText('Next', after: 2.3); // slide 2
  await tapText('Next', after: 2.3); // slide 3
  await tapText('Get started', after: 2.0); // → màn đăng nhập
}

Future<void> demoLogin() async {
  log('--- Đăng nhập ---');
  await pause(1.5);
  await typeName('Minh');
  await pause(0.8);
  await tapText('Log in', after: 2.4);
  await waitFor(find.byType(AppBottomNav), 'màn chính sau đăng nhập');
}

Future<void> demoHome() async {
  log('--- Trang chủ ---');
  await tapNav(0);
  await pause(1.5);
  await scrollDown(420);
  await scrollDown(420);
  await scrollDown(-700, seconds: 1.4); // cuộn ngược lên đầu
  await pause(1.0);
}

Future<void> demoColors() async {
  log('--- Màu sắc ---');
  await tapNav(1);
  await pause(1.6);
  await scrollDown(300); // xem qua 6 thẻ màu
  await scrollDown(-360);
  final c = kColors.first; // màu đầu tiên luôn được mở khóa
  await tapText('${c.nameEn} · ${c.compound}', after: 2.0); // mở bài học
  await scrollDown(450);
  await scrollDown(450);
  await pause(1.0);
  await popBack(after: 1.2); // về tab Màu sắc
}

Future<void> demoLearn() async {
  log('--- Tri thức ---');
  await tapNav(2);
  await pause(2.0);
  await scrollDown(260); // xem cầu vồng + các chip màu
  await scrollDown(-300);
  final band = kBands.first;
  await tapText(band.nameEn, after: 2.0); // chip màu → dải màu
  final compound = band.compounds.first;
  await waitFor(find.text(compound.name), 'dưỡng chất "${compound.name}"');
  await t.ensureVisible(find.text(compound.name).first);
  await t.pump();
  await pause(0.8);
  await tapText(compound.name, after: 2.0); // mở chi tiết dưỡng chất
  await scrollDown(450);
  await scrollDown(450);
  await pause(1.0);
  await popBack(); // về dải màu
  await popBack(); // về tab Tri thức
}

/// Trả lời lần lượt các câu hỏi (chọn đáp án ĐÚNG) rồi mở màn kết quả.
Future<void> runQuizQuestions(List<QuizQuestion> questions) async {
  for (var i = 0; i < questions.length; i++) {
    log('Câu ${i + 1}/${questions.length}');
    await waitFor(find.byType(QuizOptionCard), 'các đáp án quiz');
    await pause(2.0); // "đọc" câu hỏi
    final opt = find.byType(QuizOptionCard).at(questions[i].correctIndex);
    await t.ensureVisible(opt);
    await t.pump();
    await t.tap(opt);
    await t.pump();
    await pause(1.8); // xem đáp án được tô màu
    final isLast = i == questions.length - 1;
    await tapText(isLast ? 'See result →' : 'Next →',
        after: isLast ? 3.5 : 1.0);
  }
}

Future<void> demoQuiz() async {
  log('--- Quiz Challenge ---');
  await tapNav(3);
  await pause(1.6);
  final c = kColors.first;
  await tapText('${c.nameEn} · ${c.compound}', after: 2.0); // vào quiz màu
  await runQuizQuestions(c.quiz);
  await scrollDown(250, after: 1.2); // xem màn kết quả
  if (!await maybeTapText('Back home', after: 1.8)) await popBack();
}

Future<void> demoFoodQuiz() async {
  log('--- Food Quiz ---');
  await tapNav(3);
  await pause(1.4);
  final topic = kFoodQuizzes.first;
  await waitFor(find.text(topic.titleEn), 'food quiz "${topic.titleEn}"');
  await t.ensureVisible(find.text(topic.titleEn).first);
  await t.pump();
  await pause(0.6);
  await tapText(topic.titleEn, after: 2.0);
  await runQuizQuestions(topic.quiz);
  await pause(1.0);
  if (!await maybeTapText('Done', after: 1.8)) await popBack();
}

Future<void> demoLeaderboard() async {
  log('--- Bảng xếp hạng ---');
  await tapNav(4);
  await pause(1.8);
  await scrollDown(400);
  await scrollDown(400);
  await scrollDown(-650, seconds: 1.4);
  await pause(1.0);
}

Future<void> demoProfile() async {
  log('--- Hồ sơ ---');
  await tapNav(5);
  await pause(1.8);
  await scrollDown(420); // xem thông tin + huy hiệu
  await scrollDown(420); // tới phần cài đặt
  await waitFor(find.text('Ngôn ngữ · Language'), 'mục Ngôn ngữ');
  await t.ensureVisible(find.text('Ngôn ngữ · Language').first);
  await t.pump();
  await pause(0.8);
  await tapText('Ngôn ngữ · Language', after: 1.5); // mở dialog
  await tapText('Tiếng Việt', after: 2.5); // đổi sang tiếng Việt
  // Mở "Giới thiệu" (About Us) — UI lúc này đã là tiếng Việt
  if (await maybeTapText('Giới thiệu', after: 2.2)) {
    await scrollDown(420);
    await scrollDown(420);
    await popBack(after: 1.2);
  }
}

// ───────────────────────── Main ─────────────────────────

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Cho app render như thật trong lúc test chờ → video mượt.
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('record app demo ($kFeature)', (tester) async {
    t = tester;
    log('Bắt đầu, FEATURE=$kFeature');
    // Xóa trạng thái đã lưu để luồng luôn bắt đầu từ onboarding.
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await app.main();
    await t.pump();
    await pause(2.0); // chờ recording ổn định
    log('App đã mở');

    switch (kFeature) {
      case '01_onboarding':
        await demoOnboarding();
        break;
      case '02_login':
        if (exists(find.text('Skip'))) await tapText('Skip', after: 1.0);
        await demoLogin();
        break;
      case '03_home':
        await introFast();
        await demoHome();
        break;
      case '04_colors':
        await introFast();
        await demoColors();
        break;
      case '05_learn':
        await introFast();
        await demoLearn();
        break;
      case '06_quiz':
        await introFast();
        await demoQuiz();
        break;
      case '07_food_quiz':
        await introFast();
        await demoFoodQuiz();
        break;
      case '08_leaderboard':
        await introFast();
        await demoLeaderboard();
        break;
      case '09_profile':
        await introFast();
        await demoProfile();
        break;
      case 'all':
      default:
        await demoOnboarding();
        await demoLogin();
        await demoHome();
        await demoColors();
        await demoLearn();
        await demoQuiz();
        await demoFoodQuiz();
        await demoLeaderboard();
        await demoProfile();
    }

    log('Hoàn tất');
    await pause(2.5); // giữ khung hình cuối cho video
  }, timeout: const Timeout(Duration(minutes: 20)));
}
