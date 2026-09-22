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
  final data = json[ApiKeys.data] as List;
  final meta = json['meta']; // ممكن تكون null

  return PostsResponseModel(
    posts: data.map((post) => PostModel.fromJson(post)).toList(),
    currentPage: meta?['current_page'] ?? 1,
    lastPage: meta?['last_page'] ?? 1,
    perPage: meta?['per_page'] ?? data.length,
    total: meta?['total'] ?? data.length,
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