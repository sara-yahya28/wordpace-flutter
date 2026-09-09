

import 'package:wordspace/features/post/domain/entities/sub_enities/post_user_entity.dart';

class PostEntity {
  final int id;
  final String title;
  final String content;
  final String status;

  final PostUserEntity user;

  final int commentsCount;
  final int likesCount;
  final bool likedByMe;

  final DateTime createdAt;
  final DateTime updatedAt;

  PostEntity({
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
}