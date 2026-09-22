import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/features/post/data/models/post_model.dart';
import 'package:wordspace/features/user/data/datasources/user_local_data_source.dart';
import '../../../../core/databases/cache/cache_helper.dart';
import 'dart:convert';

abstract class LikeLocalDataSource {
  Future<List<PostModel>> getFavoritePosts();
  Future<void> saveFavoritePost(PostModel post);
  Future<void> saveAllFavoritePosts(List<PostModel> posts);
  Future<bool> isFavorite(int postId);
  Future<void> removeFavoritePost(int postId);
}

class LikeLocalDataSourceImpl implements LikeLocalDataSource {
  final CacheHelper cache;
  final UserLocalDataSource userLocalDataSource;

  LikeLocalDataSourceImpl({
    required this.cache,
    required this.userLocalDataSource,
  });

  Future<String?> _getKey() async {
    try {
      final user = await userLocalDataSource.getLastUser();
      return "CachedFavoritePosts_${user.id}";
    } on CacheException {
      return null;
    }
  }

  @override
  Future<List<PostModel>> getFavoritePosts() async {
    final key = await _getKey();
    if (key == null) return [];

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
    final key = await _getKey();
    if (key == null) return;

    final posts = await getFavoritePosts();
    final exists = posts.any((p) => p.id == post.id);
    if (!exists) {
      posts.add(post);
      final String encodedData =
          json.encode(posts.map((p) => p.toJson()).toList());
      await cache.saveData(key: key, value: encodedData);
    }
  }

  @override
  Future<void> saveAllFavoritePosts(List<PostModel> posts) async {
    final key = await _getKey();
    if (key == null) return;

    final String encodedData =
        json.encode(posts.map((p) => p.toJson()).toList());
    await cache.saveData(key: key, value: encodedData);
  }

  @override
  Future<bool> isFavorite(int postId) async {
    final posts = await getFavoritePosts();
    return posts.any((p) => p.id == postId);
  }

  @override
  Future<void> removeFavoritePost(int postId) async {
    final key = await _getKey();
    if (key == null) return;

    final posts = await getFavoritePosts();
    posts.removeWhere((p) => p.id == postId);
    final String encodedData =
        json.encode(posts.map((p) => p.toJson()).toList());
    await cache.saveData(key: key, value: encodedData);
  }
}