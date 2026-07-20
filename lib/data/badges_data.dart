import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_colors.dart';

/// The full catalogue of achievement badges (20 total).
/// Whether each is *earned* is computed in [AppState.isBadgeEarned].
const List<BadgeInfo> kBadges = [
  // Color masters — earned when the color's quiz is completed.
  BadgeInfo(id: 'red_master', emoji: '🍅', title: 'Chuyên gia màu Đỏ', subtitle: 'Hoàn thành màu Đỏ', gradient: [AppColors.red, AppColors.redLight]),
  BadgeInfo(id: 'orange_master', emoji: '🥕', title: 'Chuyên gia màu Cam', subtitle: 'Hoàn thành màu Cam', gradient: [AppColors.orange, AppColors.orangeLight]),
  BadgeInfo(id: 'yellow_master', emoji: '🌽', title: 'Chuyên gia màu Vàng', subtitle: 'Hoàn thành màu Vàng', gradient: [AppColors.yellow, AppColors.yellowDeep]),
  BadgeInfo(id: 'green_master', emoji: '🥦', title: 'Chuyên gia màu Xanh lá', subtitle: 'Hoàn thành màu Xanh lá', gradient: [AppColors.green, AppColors.greenLight]),
  BadgeInfo(id: 'blue_master', emoji: '🫐', title: 'Chuyên gia màu Xanh dương', subtitle: 'Hoàn thành màu Xanh dương', gradient: [AppColors.blue, Color(0xFF77BEFF)]),
  BadgeInfo(id: 'purple_master', emoji: '🍆', title: 'Chuyên gia màu Tím', subtitle: 'Hoàn thành màu Tím', gradient: [AppColors.purple, Color(0xFFB794FF)]),

  // Streak milestones.
  BadgeInfo(id: 'streak3', emoji: '🔥', title: 'Chuỗi 3 ngày', subtitle: 'Học 3 ngày liên tiếp', gradient: [AppColors.streak, AppColors.orange]),
  BadgeInfo(id: 'streak7', emoji: '🗓️', title: 'Chuỗi 7 ngày', subtitle: 'Học 7 ngày liên tiếp', gradient: [AppColors.red, AppColors.orange]),
  BadgeInfo(id: 'streak14', emoji: '⚡', title: 'Chuỗi 14 ngày', subtitle: 'Học 14 ngày liên tiếp', gradient: [AppColors.orange, AppColors.yellow]),
  BadgeInfo(id: 'streak30', emoji: '💪', title: 'Chuỗi 30 ngày', subtitle: 'Học 30 ngày liên tiếp', gradient: [AppColors.red, AppColors.purple]),

  // XP milestones.
  BadgeInfo(id: 'xp500', emoji: '🌱', title: '500 XP', subtitle: 'Tích lũy 500 XP', gradient: [AppColors.green, AppColors.greenLight]),
  BadgeInfo(id: 'xp1000', emoji: '💎', title: '1000 XP', subtitle: 'Tích lũy 1000 XP', gradient: [AppColors.blue, AppColors.purple]),
  BadgeInfo(id: 'xp2500', emoji: '🏆', title: '2500 XP', subtitle: 'Tích lũy 2500 XP', gradient: [AppColors.yellow, AppColors.orange]),
  BadgeInfo(id: 'xp5000', emoji: '👑', title: '5000 XP', subtitle: 'Tích lũy 5000 XP', gradient: [AppColors.yellowDeep, AppColors.orange]),

  // Quiz achievements.
  BadgeInfo(id: 'first_quiz', emoji: '⭐', title: 'Quiz đầu tiên', subtitle: 'Hoàn thành quiz đầu tiên', gradient: [AppColors.green, AppColors.greenLight]),
  BadgeInfo(id: 'perfect', emoji: '💯', title: 'Điểm tuyệt đối', subtitle: 'Đạt điểm tối đa một quiz', gradient: [AppColors.red, AppColors.orange]),
  BadgeInfo(id: 'quiz_master', emoji: '🎯', title: 'Bậc thầy Quiz', subtitle: 'Hoàn thành mọi quiz', gradient: [AppColors.purple, AppColors.blue]),
  BadgeInfo(id: 'rainbow', emoji: '🌈', title: 'Cầu vồng hoàn chỉnh', subtitle: 'Chinh phục cả 6 màu', gradient: [AppColors.red, AppColors.purple]),
  BadgeInfo(id: 'explorer', emoji: '🧭', title: 'Nhà thám hiểm', subtitle: 'Mở khóa mọi màu sắc', gradient: [AppColors.blue, AppColors.green]),
  BadgeInfo(id: 'diligent', emoji: '📚', title: 'Chăm học', subtitle: 'Đọc 3 bài học', gradient: [AppColors.orange, AppColors.yellow]),
];

BadgeInfo badgeById(String id) => kBadges.firstWhere((b) => b.id == id);
