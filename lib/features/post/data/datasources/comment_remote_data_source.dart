import 'package:wordspace/core/databases/api/api_consumer.dart';
import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/post/data/models/comment_model.dart';

abstract class CommentRemoteDataSource {
  //عرض التعليقات
  Future<List<CommentModel>> getComments(int postId);
//إضافة تعليق
  Future<CommentModel> addComment(int postId, String body);

}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final ApiConsumer api;

  CommentRemoteDataSourceImpl({required this.api});

  @override
  Future<List<CommentModel>> getComments(int postId) async {
    final response = await api.get(
      EndPoints.postComments(postId),
    );

    final List<dynamic> commentsJson = response[ApiKeys.data];

//هذا يرجع model وال implementation في الـRepository يحولهم إلى Entity
    return commentsJson
        // تحويل الـJSON إلى قائمة من CommentModel
        .map((json) => CommentModel.fromJson(json))
        // تحويلهم إلى List<CommentModel>
        .toList();
  }
  
    @override
  Future<CommentModel> addComment(int postId, String body) async {
    final response = await api.post(
      EndPoints.postComments(postId),
      data: {
        'body': body,
      },
    );

    return CommentModel.fromJson(response[ApiKeys.data]);
  }


}