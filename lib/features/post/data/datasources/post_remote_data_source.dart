// هذا الملف يتواصل مع الـAPI ويجيب الـPosts
import 'package:wordspace/core/databases/api/api_consumer.dart';
import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/post/data/models/post_model.dart';
import 'package:wordspace/features/post/data/models/posts_response_model.dart';

//  يتواصل مع الـAPI ويجيب الـPosts
abstract class PostRemoteDataSource {
  Future<PostsResponseModel> getPosts(int page);
  Future<PostModel> createPost({
    required String title,
    required String body,
    required String status,

  });
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final ApiConsumer api;

  PostRemoteDataSourceImpl({required this.api});

  @override
  Future<PostsResponseModel> getPosts(int page) async {
    final response = await api.get(
      EndPoints.posts,
      queryParameters: {
        'page': page,
      },
    );

    return PostsResponseModel.fromJson(response);
    //يحول الـJSON إلى PostsResponseModel
  }

@override
Future<PostModel> createPost({
  required String title,
  required String body,
  required String status,
}) async {
  final response = await api.post(
    EndPoints.posts,
    data: {
      ApiKeys.title: title,
      ApiKeys.body: body,
      ApiKeys.status: status,
    },
  );

  return PostModel.fromJson(response['data']);
}
}
