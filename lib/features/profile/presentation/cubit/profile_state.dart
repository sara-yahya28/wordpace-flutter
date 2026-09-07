import 'package:wordspace/features/profile/domain/entities/profile_entity.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

// حالات جلب بيانات وإحصائيات البروفايل
class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {
  final ProfileEntity profile;
  GetProfileSuccessState({required this.profile});
}

class GetProfileErrorState extends ProfileState {
  final String errMessage;
  GetProfileErrorState({required this.errMessage});
}

// حالات جلب منشوراتي
class GetMyPostsLoadingState extends ProfileState {}

class GetMyPostsSuccessState extends ProfileState {
  final List<PostEntity> myPosts;
  GetMyPostsSuccessState({required this.myPosts});
}

class GetMyPostsErrorState extends ProfileState {
  final String errMessage;
  GetMyPostsErrorState({required this.errMessage});
}