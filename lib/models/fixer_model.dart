class Fixer {
  final int id;
  final String name;
  final String email;
  final String aboutMe;
  final int? maxDistance;
  final String userType;
  final String createdAt;
  final String updatedAt;
  final String servicesProvides;

  Fixer({
    required this.id,
    required this.name,
    required this.email,
    required this.aboutMe,
    this.maxDistance,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    required this.servicesProvides,
  });

  factory Fixer.fromJson(Map<String, dynamic> json) {
    return Fixer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      aboutMe: json['about_me'],
      maxDistance: json['max_distance'],
      userType: json['user_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      servicesProvides: json['services_prodvides'],
    );
  }
}
