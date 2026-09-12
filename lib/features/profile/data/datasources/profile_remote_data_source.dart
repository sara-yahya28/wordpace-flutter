import 'package:wordspace/core/databases/api/api_consumer.dart';
import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/profile/data/models/profile_model.dart';
import 'package:wordspace/features/post/data/models/post_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfileStats();
  Future<List<PostModel>> getMyPosts();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiConsumer api;

  ProfileRemoteDataSourceImpl({required this.api});

  @override
  Future<ProfileModel> getProfileStats() async {
    final response = await api.get(EndPoints.user);
    return ProfileModel.fromJson(response);
  }

  @override
  Future<List<PostModel>> getMyPosts() async {
    final response = await api.get(EndPoints.posts, queryParameters: {'my_posts': true});
    return (response[ApiKeys.data] as List)
        .map((e) => PostModel.fromJson(e))
        .toList();
  }
}