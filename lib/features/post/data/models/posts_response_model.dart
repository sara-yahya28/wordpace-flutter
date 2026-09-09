//بيانات meta (كم صفحة عندي وكيف أعرف إذا باقي Posts)
//يمثل استجابة GET /posts كاملة
import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/post/data/models/post_model.dart';
import 'package:wordspace/features/post/domain/entities/posts_response_entity.dart';

class PostsResponseModel {
  final List<PostModel> posts;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  PostsResponseModel({
    required this.posts,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PostsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json[ApiKeys.data];
    final meta = json['meta'];

    return PostsResponseModel(
      posts: (data as List)
          .map((post) => PostModel.fromJson(post))
          .toList(),
      currentPage: meta['current_page'],
      lastPage: meta['last_page'],
      perPage: meta['per_page'],
      total: meta['total'],
    );
  }

  PostsResponseEntity toEntity() {
    return PostsResponseEntity(
      posts: posts.map((post) => post.toEntity()).toList(),
      currentPage: currentPage,
      lastPage: lastPage,
      perPage: perPage,
      total: total,
    );
  }
}