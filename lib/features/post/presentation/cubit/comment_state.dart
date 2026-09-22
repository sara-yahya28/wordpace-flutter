import 'package:wordspace/features/post/domain/entities/comment_entity.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {
  final List<CommentEntity> comments;

  CommentSuccess({
    required this.comments,
  });
}

class CommentFailure extends CommentState {
  final String message;

  CommentFailure({
    required this.message,
  });
}
//لإضافة الكومنت
class CommentAdding extends CommentState {}

class CommentAddFailure extends CommentState {
  final String message;

  CommentAddFailure({
    required this.message,
  });
}
//للحذف
class CommentDeleting extends CommentState {}

class CommentDeleteSuccess extends CommentState {
  final List<CommentEntity> comments;

  CommentDeleteSuccess({
    required this.comments,
  });
}

class CommentDeleteFailure extends CommentState {
  final String message;

  CommentDeleteFailure({
    required this.message,
  });
}