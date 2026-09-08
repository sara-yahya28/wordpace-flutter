

import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
//هذه الـEntity تمثل البيانات التي نحتاجها من استجابة /posts داخل الـDomain

class PostsResponseEntity {
  final List<PostEntity> posts;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  PostsResponseEntity({
    required this.posts,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });
}