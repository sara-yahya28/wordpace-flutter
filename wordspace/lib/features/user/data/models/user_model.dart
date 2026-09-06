import 'package:wordspace/core/databases/api/end_points.dart';
import '../../domain/entities/user_entitiy.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? role;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.role,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  //Model To Json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[ApiKeys.id],
      name: json[ApiKeys.name],
      email: json[ApiKeys.email],
      role: json[ApiKeys.role],
      emailVerifiedAt: json[ApiKeys.emailVerifiedAt] != null
          ? DateTime.parse(json[ApiKeys.emailVerifiedAt])
          : null,
      createdAt: DateTime.parse(json[ApiKeys.createdAt]),
      updatedAt: DateTime.parse(json[ApiKeys.updatedAt]),
    );
  }

// Json To Model
  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.role: role,
      ApiKeys.emailVerifiedAt: emailVerifiedAt?.toIso8601String(),
      ApiKeys.createdAt: createdAt.toIso8601String(),
      ApiKeys.updatedAt: updatedAt.toIso8601String(),
    };
  }

  // تحويل من Model إلى Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      role: role,
      emailVerifiedAt: emailVerifiedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // تحويل من Entity إلى Model
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      role: entity.role,
      emailVerifiedAt: entity.emailVerifiedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}