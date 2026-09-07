import '../databases/api/end_points.dart';

class NoParams {
  const NoParams();
}

class UserParams {
  final String id;
  
  UserParams({required this.id});
}
class GetUserParams {
  const GetUserParams(); 
}

class GetProfileStatsParams {
  const GetProfileStatsParams(); }

class GetPostParams {
  final int postId;
  GetPostParams({required this.postId});
}
class CreatePostParams {
  final String title;
  final String content;
  final String status;
  CreatePostParams({
    required this.title,
    required this.content,
    required this.status,
  });
}

class UpdatePostParams {
  final int postId;
  final String? title;
  final String? content;
  final String? status;

  UpdatePostParams({
    required this.postId,
    this.title,
    this.content,
    this.status,
  });
}
class DeletePostParams {
  final int postId;
  DeletePostParams({required this.postId});
}

class CreateCommentParams {
  final int postId;
  final String content;

  CreateCommentParams({
    required this.postId,
    required this.content,
  });
}

class DeleteCommentParams {
  final int postId;
  final int commentId;

  DeleteCommentParams({
    required this.postId,
    required this.commentId,
  });
}

class LikePostParams {
  final int postId;
  LikePostParams({required this.postId});
}

class UnlikePostParams {
  final int postId;
  UnlikePostParams({required this.postId});
}

class GetPostLikesParams {
  final int postId;
  GetPostLikesParams({required this.postId});
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    ApiKeys.email: email,
    ApiKeys.password: password,
  };
}

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => {
    ApiKeys.name: name,
    ApiKeys.email: email,
    ApiKeys.password: password,
    ApiKeys.passwordConfirmation: passwordConfirmation,
  };
}

/*
What Was Done
WHAT:
   - Defines parameter classes for all use cases and remote data source calls.
   - Each class holds the required data for a specific operation.

   CLASSES:
   - UserParams: { id } for fetching a user.
   - LoginParams: { email, password } for authentication.
   - RegisterParams: { name, email, password, passwordConfirmation }.
   - PostParams, CreatePostParams, UpdatePostParams, DeletePostParams, etc.
   - CommentParams, LikeParams, etc.
 */