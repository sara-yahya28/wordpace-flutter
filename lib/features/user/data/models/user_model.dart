import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/user/domain/entities/user_entitiy.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // ✅ Directly reads fields from the flat JSON
    return UserModel(
      id: json[ApiKeys.id] ?? 0,
      name: json[ApiKeys.name] ?? '',
      email: json[ApiKeys.email] ?? '',
      role: json[ApiKeys.role] ?? 'user',
      emailVerifiedAt: json[ApiKeys.emailVerifiedAt],
      createdAt: json[ApiKeys.createdAt] ?? '',
      updatedAt: json[ApiKeys.updatedAt] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.role: role,
      ApiKeys.emailVerifiedAt: emailVerifiedAt,
      ApiKeys.createdAt: createdAt,
      ApiKeys.updatedAt: updatedAt,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      role: role,
      createdAt: _parseDateTime(createdAt),
      updatedAt: _parseDateTime(updatedAt),
    );
  }

  DateTime _parseDateTime(String value) {
    if (value.isEmpty) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }

    return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }
}

/*
WHAT:
   - Represents user data from the new API.
   - Reads fields directly from the flat JSON structure.

   NEW API FORMAT:
   - Fields are at the top level: id, name, email, role, token, created_at.
   - No nesting, no wrapper objects.

   SIMPLICITY:
   - fromJson() reads fields directly from the JSON.
   - No conditional logic, no nested extraction.
   - Clean and maintainable.


*/