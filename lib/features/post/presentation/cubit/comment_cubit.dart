import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/post/domain/entities/comment_entity.dart';
import 'package:wordspace/features/post/domain/usecases/get_comments_usecase.dart';

import 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final GetCommentsUseCase getCommentsUseCase;

  CommentCubit({
    required this.getCommentsUseCase,
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
}