import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
import 'package:wordspace/features/post/domain/entities/sub_enities/post_user_entity.dart';

//يمثل Post واحد
class PostModel {
  final int id;
  final String title;
  final String content;
  final String status;

  final PostUserModel user;

  final int commentsCount;
  final int likesCount;
  final bool likedByMe;

  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.user,
    required this.commentsCount,
    required this.likesCount,
    required this.likedByMe,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json[ApiKeys.id],
      title: json[ApiKeys.title],
      content: json[ApiKeys.body],
      status: json[ApiKeys.status],
      user: PostUserModel.fromJson(json[ApiKeys.user]),
      commentsCount: json[ApiKeys.commentsCount],
      likesCount: json[ApiKeys.likesCount],
      likedByMe: json[ApiKeys.likedByMe] ?? false,
      createdAt: DateTime.parse(json[ApiKeys.createdAt]),
      updatedAt: DateTime.parse(json[ApiKeys.updatedAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.title: title,
      ApiKeys.content: content,
      ApiKeys.status: status,
      ApiKeys.user: user.toJson(),
      ApiKeys.commentsCount: commentsCount,
      ApiKeys.likesCount: likesCount,
      ApiKeys.likedByMe: likedByMe,
      ApiKeys.createdAt: createdAt.toIso8601String(),
      ApiKeys.updatedAt: updatedAt.toIso8601String(),
    };
  }

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      title: title,
      content: content,
      status: status,
      user: user.toEntity(),
      commentsCount: commentsCount,
      likesCount: likesCount,
      likedByMe: likedByMe,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      status: entity.status,
      user: PostUserModel.fromEntity(entity.user),
      commentsCount: entity.commentsCount,
      likesCount: entity.likesCount,
      likedByMe: entity.likedByMe,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

class PostUserModel {
  final int id;
  final String name;

  PostUserModel({
    required this.id,
    required this.name,
  });

  factory PostUserModel.fromJson(Map<String, dynamic> json) {
    return PostUserModel(
      id: json[ApiKeys.id],
      name: json[ApiKeys.name],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.name: name,
    };
  }

  PostUserEntity toEntity() {
    return PostUserEntity(
      id: id,
      name: name,
    );
  }

  factory PostUserModel.fromEntity(PostUserEntity entity) {
    return PostUserModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
