import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/about_models.dart';
import '../state/about_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';

/// The "About Us" page: project mission/vision/values and the founders.
/// A gear icon opens an admin login; once signed in, the content becomes
/// editable (edit/add/remove founders, edit about text, change password).
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const Color _accent = AppColors.purple;

  Future<void> _launch(BuildContext context, Uri uri) async {
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) {
        _snack(context, 'Không mở được: ${uri.toString()}');
      }
    } catch (_) {
      if (context.mounted) _snack(context, 'Không mở được: ${uri.toString()}');
    }
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWarm,
      body: Consumer<AboutState>(
        builder: (context, about, _) {
          return Column(
            children: [
              _Header(
                isAdmin: about.isAdmin,
                onGear: () => _onGear(context, about),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (about.isAdmin) ...[
                        _AdminBanner(onLogout: about.logout),
                        const SizedBox(height: 16),
                      ],
                      Text(
                        'Nutrition Rainbow is a passion project turning '
                        'nutritional data into healthier, more colorful '
                        'choices — accessibly and accurately.',
                        style: AppText.body(
                            size: 14.5,
                            height: 1.6,
                            color: AppColors.inkSoft),
                      ),
                      const SizedBox(height: 22),

                      // ── Mission / Vision / Values ──
                      Row(
                        children: [
                          Text('Our purpose',
                              style: AppText.fredoka(
                                  size: 18, weight: FontWeight.w500)),
                          const SizedBox(width: 8),
                          Text('· Tôn chỉ',
                              style: AppText.body(
                                  size: 13, color: AppColors.muted2)),
                          const Spacer(),
                          if (about.isAdmin)
                            _EditIcon(
                                onTap: () => _editAbout(context, about)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _AboutBlock(
                        emoji: '🎯',
                        label: 'Mission · Sứ mệnh',
                        text: about.mission,
                        accent: _accent,
                      ),
                      const SizedBox(height: 10),
                      _AboutBlock(
                        emoji: '🔭',
                        label: 'Vision · Tầm nhìn',
                        text: about.vision,
                        accent: AppColors.blue,
                      ),
                      const SizedBox(height: 10),
                      _AboutBlock(
                        emoji: '💎',
                        label: 'Values · Giá trị',
                        text: about.values,
                        accent: AppColors.green,
                      ),
                      const SizedBox(height: 26),

                      // ── Founders ──
                      Row(
                        children: [
                          Text('Founders',
                              style: AppText.fredoka(
                                  size: 18, weight: FontWeight.w500)),
                          const SizedBox(width: 8),
                          Text('· Người sáng lập',
                              style: AppText.body(
                                  size: 13, color: AppColors.muted2)),
                          const Spacer(),
                          if (about.isAdmin)
                            _AddButton(
                                onTap: () =>
                                    _editFounder(context, about, null, null)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (about.founders.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.chip,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            about.isAdmin
                                ? 'Chưa có người sáng lập nào · chạm "Thêm" để thêm.'
                                : 'Chưa có thông tin người sáng lập.',
                            style:
                                AppText.body(size: 13, color: AppColors.muted),
                          ),
                        ),
                      for (var i = 0; i < about.founders.length; i++) ...[
                        _FounderCard(
                          founder: about.founders[i],
                          isAdmin: about.isAdmin,
                          onEmail: () => _launch(context,
                              Uri(scheme: 'mailto', path: about.founders[i].email)),
                          onPhone: () => _launch(
                              context,
                              Uri(
                                  scheme: 'tel',
                                  path: about.founders[i].phone
                                      .replaceAll(RegExp(r'\s+'), ''))),
                          onEdit: () => _editFounder(
                              context, about, i, about.founders[i]),
                          onDelete: () =>
                              _confirmDelete(context, about, i),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Admin actions ──────────────────────────────────────────
  void _onGear(BuildContext context, AboutState about) {
    if (about.isAdmin) {
      _adminMenu(context, about);
    } else {
      _login(context, about);
    }
  }

  Future<void> _login(BuildContext context, AboutState about) async {
    final controller = TextEditingController();
    String? error;
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInner) => AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Admin login', style: AppText.fredoka(size: 20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Đăng nhập quản trị viên để chỉnh sửa nội dung.',
                  style: AppText.body(size: 13, color: AppColors.muted)),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                autofocus: true,
                obscureText: true,
                onSubmitted: (_) =>
                    _trySubmit(ctx, about, controller.text, setInner,
                        (e) => error = e),
                decoration: InputDecoration(
                  hintText: 'Mật khẩu',
                  errorText: error,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Hủy')),
            TextButton(
              onPressed: () => _trySubmit(
                  ctx, about, controller.text, setInner, (e) => error = e),
              child: Text('Đăng nhập',
                  style: AppText.body(
                      size: 14,
                      weight: FontWeight.w700,
                      color: _accent)),
            ),
          ],
        ),
      ),
    );
    controller.dispose();
  }

  void _trySubmit(BuildContext ctx, AboutState about, String pw,
      void Function(void Function()) setInner, void Function(String?) setError) {
    if (about.login(pw)) {
      Navigator.pop(ctx);
    } else {
      setInner(() => setError('Sai mật khẩu'));
    }
  }

  void _adminMenu(BuildContext context, AboutState about) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.lineDark,
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.password_rounded),
              title: Text('Đổi mật khẩu', style: AppText.body(size: 15)),
              onTap: () {
                Navigator.pop(ctx);
                _changePassword(context, about);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: AppColors.red),
              title: Text('Đăng xuất',
                  style: AppText.body(size: 15, color: AppColors.red)),
              onTap: () {
                Navigator.pop(ctx);
                about.logout();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword(BuildContext context, AboutState about) async {
    final controller = TextEditingController();
    final pw = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Đổi mật khẩu', style: AppText.fredoka(size: 20)),
        content: TextField(
          controller: controller,
          autofocus: true,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Mật khẩu mới'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, controller.text),
              child: Text('Lưu',
                  style: AppText.body(
                      size: 14, weight: FontWeight.w700, color: _accent))),
        ],
      ),
    );
    controller.dispose();
    if (pw != null && pw.trim().isNotEmpty) {
      await about.changePassword(pw);
      if (context.mounted) _snack(context, 'Đã đổi mật khẩu.');
    }
  }

  Future<void> _editAbout(BuildContext context, AboutState about) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => _AboutForm(
        mission: about.mission,
        vision: about.vision,
        values: about.values,
      ),
    );
    if (result != null) {
      await about.updateAbout(
        mission: result['mission'] ?? about.mission,
        vision: result['vision'] ?? about.vision,
        values: result['values'] ?? about.values,
      );
    }
  }

  Future<void> _editFounder(
      BuildContext context, AboutState about, int? index, Founder? f) async {
    final result = await showModalBottomSheet<Founder>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => _FounderForm(founder: f),
    );
    if (result != null) await about.upsertFounder(index, result);
  }

  Future<void> _confirmDelete(
      BuildContext context, AboutState about, int index) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Xóa người này?', style: AppText.fredoka(size: 20)),
        content: Text('${about.founders[index].name} sẽ bị xóa khỏi trang.',
            style: AppText.body(size: 14)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Hủy')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text('Xóa',
                  style: AppText.body(
                      size: 14,
                      weight: FontWeight.w700,
                      color: AppColors.red))),
        ],
      ),
    );
    if (ok == true) await about.removeFounder(index);
  }
}

// ═══════════════════════════════ Header ═══════════════════════════════
class _Header extends StatelessWidget {
  const _Header({required this.isAdmin, required this.onGear});
  final bool isAdmin;
  final VoidCallback onGear;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.purple, AppColors.blue],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleIconBtn(
                      icon: Icons.arrow_back_rounded,
                      onTap: () => Navigator.of(context).maybePop()),
                  _CircleIconBtn(
                    icon: isAdmin
                        ? Icons.admin_panel_settings_rounded
                        : Icons.settings_rounded,
                    highlighted: isAdmin,
                    onTap: onGear,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('GIỚI THIỆU',
                  style: AppText.body(
                      size: 12,
                      weight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Colors.white.withOpacity(0.85))),
              const SizedBox(height: 3),
              Text('About Us',
                  style: AppText.fredoka(size: 27, color: Colors.white)),
              const SizedBox(height: 3),
              Text('Meet the team behind Nutrition Rainbow',
                  style: AppText.body(
                      size: 13.5, color: Colors.white.withOpacity(0.92))),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIconBtn extends StatelessWidget {
  const _CircleIconBtn(
      {required this.icon, required this.onTap, this.highlighted = false});
  final IconData icon;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(highlighted ? 0.42 : 0.22),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

// ═══════════════════════════ Admin banner ═════════════════════════════
class _AdminBanner extends StatelessWidget {
  const _AdminBanner({required this.onLogout});
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.purple.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.purple.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Text('🔓', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Text('Admin mode · bạn có thể chỉnh sửa nội dung',
                style: AppText.body(
                    size: 12.5,
                    weight: FontWeight.w600,
                    color: AppColors.purple)),
          ),
          GestureDetector(
            onTap: onLogout,
            child: Text('Đăng xuất',
                style: AppText.body(
                    size: 12.5,
                    weight: FontWeight.w700,
                    color: AppColors.red)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════ About block ══════════════════════════════
class _AboutBlock extends StatelessWidget {
  const _AboutBlock({
    required this.emoji,
    required this.label,
    required this.text,
    required this.accent,
  });
  final String emoji;
  final String label;
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.small,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppText.body(
                        size: 12, weight: FontWeight.w700, color: accent)),
                const SizedBox(height: 4),
                Text(text.isEmpty ? '—' : text,
                    style: AppText.body(
                        size: 14, height: 1.55, color: AppColors.inkSoft)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════ Founder card ═════════════════════════════
class _FounderCard extends StatelessWidget {
  const _FounderCard({
    required this.founder,
    required this.isAdmin,
    required this.onEmail,
    required this.onPhone,
    required this.onEdit,
    required this.onDelete,
  });
  final Founder founder;
  final bool isAdmin;
  final VoidCallback onEmail;
  final VoidCallback onPhone;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.small,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.purple, AppColors.blue],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                    child: Text(founder.emoji,
                        style: const TextStyle(fontSize: 26))),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(founder.name,
                        style:
                            AppText.fredoka(size: 17, weight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text(founder.school,
                        style: AppText.body(
                            size: 12.5, height: 1.4, color: AppColors.muted)),
                  ],
                ),
              ),
              if (isAdmin)
                Row(
                  children: [
                    _EditIcon(onTap: onEdit),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.red.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: const Icon(Icons.delete_outline_rounded,
                            size: 17, color: AppColors.red),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 14),
          if (founder.email.isNotEmpty)
            _ContactRow(
                icon: Icons.email_outlined, text: founder.email, onTap: onEmail),
          if (founder.email.isNotEmpty && founder.phone.isNotEmpty)
            const SizedBox(height: 8),
          if (founder.phone.isNotEmpty)
            _ContactRow(
                icon: Icons.call_outlined, text: founder.phone, onTap: onPhone),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow(
      {required this.icon, required this.text, required this.onTap});
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.chip,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 17, color: AppColors.purple),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text,
                  style: AppText.body(
                      size: 13.5,
                      weight: FontWeight.w600,
                      color: AppColors.inkSoft)),
            ),
            Icon(Icons.arrow_outward_rounded,
                size: 15, color: AppColors.muted3),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════ Small buttons ════════════════════════════
class _EditIcon extends StatelessWidget {
  const _EditIcon({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.purple.withOpacity(0.12),
          borderRadius: BorderRadius.circular(9),
        ),
        child: const Icon(Icons.edit_rounded, size: 16, color: AppColors.purple),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Pill(
        background: AppColors.purple.withOpacity(0.12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_rounded, size: 16, color: AppColors.purple),
            const SizedBox(width: 4),
            Text('Thêm',
                style: AppText.body(
                    size: 12.5,
                    weight: FontWeight.w700,
                    color: AppColors.purple)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════ Edit forms ═══════════════════════════════
class _FounderForm extends StatefulWidget {
  const _FounderForm({this.founder});
  final Founder? founder;

  @override
  State<_FounderForm> createState() => _FounderFormState();
}

class _FounderFormState extends State<_FounderForm> {
  late final TextEditingController _name =
      TextEditingController(text: widget.founder?.name ?? '');
  late final TextEditingController _school =
      TextEditingController(text: widget.founder?.school ?? '');
  late final TextEditingController _email =
      TextEditingController(text: widget.founder?.email ?? '');
  late final TextEditingController _phone =
      TextEditingController(text: widget.founder?.phone ?? '');
  late final TextEditingController _emoji =
      TextEditingController(text: widget.founder?.emoji ?? '🎓');

  @override
  void dispose() {
    _name.dispose();
    _school.dispose();
    _email.dispose();
    _phone.dispose();
    _emoji.dispose();
    super.dispose();
  }

  void _save() {
    if (_name.text.trim().isEmpty) return;
    Navigator.pop(
      context,
      Founder(
        name: _name.text.trim(),
        school: _school.text.trim(),
        email: _email.text.trim(),
        phone: _phone.text.trim(),
        emoji: _emoji.text.trim().isEmpty ? '🎓' : _emoji.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SheetShell(
      title: widget.founder == null ? 'Thêm người sáng lập' : 'Chỉnh sửa',
      onSave: _save,
      children: [
        _Field(controller: _emoji, label: 'Emoji đại diện'),
        _Field(controller: _name, label: 'Họ và tên'),
        _Field(controller: _school, label: 'Trường / tổ chức'),
        _Field(
            controller: _email,
            label: 'Email',
            keyboardType: TextInputType.emailAddress),
        _Field(
            controller: _phone,
            label: 'Số điện thoại',
            keyboardType: TextInputType.phone),
      ],
    );
  }
}

class _AboutForm extends StatefulWidget {
  const _AboutForm(
      {required this.mission, required this.vision, required this.values});
  final String mission;
  final String vision;
  final String values;

  @override
  State<_AboutForm> createState() => _AboutFormState();
}

class _AboutFormState extends State<_AboutForm> {
  late final TextEditingController _mission =
      TextEditingController(text: widget.mission);
  late final TextEditingController _vision =
      TextEditingController(text: widget.vision);
  late final TextEditingController _values =
      TextEditingController(text: widget.values);

  @override
  void dispose() {
    _mission.dispose();
    _vision.dispose();
    _values.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SheetShell(
      title: 'Chỉnh sửa tôn chỉ',
      onSave: () => Navigator.pop(context, {
        'mission': _mission.text,
        'vision': _vision.text,
        'values': _values.text,
      }),
      children: [
        _Field(controller: _mission, label: 'Mission · Sứ mệnh', maxLines: 3),
        _Field(controller: _vision, label: 'Vision · Tầm nhìn', maxLines: 3),
        _Field(controller: _values, label: 'Values · Giá trị', maxLines: 2),
      ],
    );
  }
}

/// Shared bottom-sheet scaffold with a title, scrollable body and Save button.
class _SheetShell extends StatelessWidget {
  const _SheetShell(
      {required this.title, required this.onSave, required this.children});
  final String title;
  final VoidCallback onSave;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppColors.lineDark,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 14),
              Text(title, style: AppText.fredoka(size: 20)),
              const SizedBox(height: 14),
              ...children,
              const SizedBox(height: 8),
              PrimaryButton(
                  label: 'Lưu', color: AppColors.purple, onTap: onSave),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.keyboardType,
  });
  final TextEditingController controller;
  final String label;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: AppText.body(size: 14, color: AppColors.ink),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppColors.bgWarm,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
