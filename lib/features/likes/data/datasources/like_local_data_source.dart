import 'package:wordspace/features/post/data/models/post_model.dart';
import '../../../../core/databases/cache/cache_helper.dart';
import 'dart:convert';

abstract class LikeLocalDataSource {
  Future<List<PostModel>> getFavoritePosts();
  Future<void> saveFavoritePost(PostModel post);
  Future<bool> isFavorite(int postId);
  Future<void> removeFavoritePost(int postId);
}

class LikeLocalDataSourceImpl implements LikeLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedFavoritePosts"; // Changed key to be more specific
  LikeLocalDataSourceImpl({required this.cache});

  @override
  Future<List<PostModel>> getFavoritePosts() async {
    final jsonString = cache.getDataString(key: key);
    if (jsonString != null) {
      final List decodedJson = json.decode(jsonString);
      final List<PostModel> posts = decodedJson
          .map((item) => PostModel.fromJson(item))
          .toList();
      return posts;
    } else {
      return [];
    }
  }

  @override
  Future<void> saveFavoritePost(PostModel post) async {
    final posts = await getFavoritePosts();
    final exist = posts.any((p) => p.id == post.id);
    if (!exist) {
      posts.add(post);
      final String encodedData =
          json.encode(posts.map((p) => p.toJson()).toList());
      await cache.saveData(key: key, value: encodedData);
    }
  }

  @override
  Future<bool> isFavorite(int postId) async {
    final post = await getFavoritePosts();
    final isLiked = post.any((p) => p.id == postId);
    return isLiked;
  }

  @override
  Future<void> removeFavoritePost(int postId) async {
    final post = await getFavoritePosts();
    post.removeWhere((p) => p.id == postId);
    final String encodedData =
        json.encode(post.map((p) => p.toJson()).toList());
    await cache.saveData(key: key, value: encodedData);
  }
}