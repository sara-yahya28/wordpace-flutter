import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/post/domain/entities/comment_entity.dart';

class CommentModel {
  final int id;
  final String content;
  final int postId;
  final String userName;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.content,
    required this.postId,
    required this.userName,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json[ApiKeys.id],
      content: json[ApiKeys.commentContent],
      postId: json[ApiKeys.postId],
      userName: json[ApiKeys.user][ApiKeys.name],
      createdAt: DateTime.parse(json[ApiKeys.createdAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.commentContent: content,
      ApiKeys.postId: postId,
      ApiKeys.user: {
        ApiKeys.name: userName,
      },
      ApiKeys.createdAt: createdAt.toIso8601String(),
    };
  }

  CommentEntity toEntity() {
    return CommentEntity(
      id: id,
      content: content,
      postId: postId,
      userName: userName,
      createdAt: createdAt,
    );
  }

  factory CommentModel.fromEntity(CommentEntity entity) {
    return CommentModel(
      id: entity.id,
      content: entity.content,
      postId: entity.postId,
      userName: entity.userName,
      createdAt: entity.createdAt,
    );
  }
}