/// A founder / team member shown on the About Us page.
class Founder {
  const Founder({
    required this.name,
    required this.school,
    required this.email,
    required this.phone,
    this.emoji = '🎓',
  });

  final String name;
  final String school;
  final String email;
  final String phone;
  final String emoji;

  Founder copyWith({
    String? name,
    String? school,
    String? email,
    String? phone,
    String? emoji,
  }) {
    return Founder(
      name: name ?? this.name,
      school: school ?? this.school,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      emoji: emoji ?? this.emoji,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'school': school,
        'email': email,
        'phone': phone,
        'emoji': emoji,
      };

  factory Founder.fromJson(Map<String, dynamic> j) => Founder(
        name: j['name'] as String? ?? '',
        school: j['school'] as String? ?? '',
        email: j['email'] as String? ?? '',
        phone: j['phone'] as String? ?? '',
        emoji: j['emoji'] as String? ?? '🎓',
      );
}
