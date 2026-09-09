


// هذا الملف يتواصل مع الـAPI ويجيب الـPosts
import 'package:wordspace/core/databases/api/api_consumer.dart';
import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/post/data/models/posts_response_model.dart';

abstract class PostRemoteDataSource {
  Future<PostsResponseModel> getPosts(int page);
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
}