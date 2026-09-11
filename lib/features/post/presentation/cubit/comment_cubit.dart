import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/post/domain/entities/comment_entity.dart';
import 'package:wordspace/features/post/domain/usecases/get_comments_usecase.dart';
import 'package:wordspace/features/post/domain/usecases/add_comment_usecase.dart';
import 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final GetCommentsUseCase getCommentsUseCase;
final AddCommentUseCase addCommentUseCase;
  CommentCubit({
    required this.getCommentsUseCase,
    required this.addCommentUseCase,
  }) : super(CommentInitial());

  List<CommentEntity> comments = [];

  Future<void> getComments(int postId) async {
    emit(CommentLoading());

    final result = await getCommentsUseCase(postId);

    result.fold(
      (failure) {
        emit(
          CommentFailure(
            message: failure.errMessage,
          ),
        );
      },
      (comments) {
        this.comments = comments;

        emit(
          CommentSuccess(
            comments: comments,
          ),
        );
      },
    );
  }
Future<void> addComment(int postId, String body) async {
  emit(CommentAdding());

  final result = await addCommentUseCase(postId, body);

  result.fold(
    (failure) {
      emit(
        CommentAddFailure(
          message: failure.errMessage,
        ),
      );
    },
    (comment) {
      comments.add(comment);

      emit(
        CommentSuccess(
          comments: comments,
        ),
      );
    },
  );
}


}