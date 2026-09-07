class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? role; 
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.role,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });
}