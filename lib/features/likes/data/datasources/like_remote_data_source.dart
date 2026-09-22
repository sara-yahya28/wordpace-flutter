import 'package:wordspace/core/databases/api/api_consumer.dart';
import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/likes/data/models/like_response_model.dart';
import 'package:wordspace/features/post/data/models/posts_response_model.dart';

abstract class LikeRemoteDataSource {
  Future<PostsResponseModel> getLikedPosts(int page);
  Future<LikeResponseModel> toggleLike(int postId);
}

class LikeRemoteDataSourceImpl implements LikeRemoteDataSource {
  final ApiConsumer apiConsumer;

  LikeRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<PostsResponseModel> getLikedPosts(int page) async {
    final response = await apiConsumer.get(
      EndPoints.likedPosts,
      queryParameters: {'page': page},
    );
    return PostsResponseModel.fromJson(response);
  }

  @override
  Future<LikeResponseModel> toggleLike(int postId) async {

final response=await apiConsumer.post(
  EndPoints.toggleLike(postId),
) ;
return LikeResponseModel.fromJson(response);
  }
}
