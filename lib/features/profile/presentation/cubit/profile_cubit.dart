import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/params/params.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
import 'package:wordspace/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:wordspace/features/profile/domain/entities/profile_entity.dart';
import 'package:wordspace/features/profile/domain/usecases/get_my_posts_usecase.dart';
import 'package:wordspace/features/profile/domain/usecases/get_profile_stats_usecase.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileStatsUseCase getProfileStatsUseCase;
  final GetMyPostsUseCase getMyPostsUseCase;
  final DeletePostUseCase deletePostUseCase;

  ProfileCubit({
    required this.getProfileStatsUseCase,
    required this.getMyPostsUseCase,
    required this.deletePostUseCase,
  }) : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileEntity? profileData;
  List<PostEntity> myPostsList = [];

  Future<void> getProfileStats() async {
    emit(GetProfileLoadingState());

    final result = await getProfileStatsUseCase(const GetProfileStatsParams());

    result.fold(
      (failure) => emit(GetProfileErrorState(errMessage: failure.errMessage)),
      (profile) {
        profileData = profile;
        emit(GetProfileSuccessState(profile: profile));
        getMyPosts(); // جلب المنشورات
      },
    );
  }

  Future<void> getMyPosts() async {
    emit(GetMyPostsLoadingState());

    final result = await getMyPostsUseCase();

    result.fold(
      (failure) => emit(GetMyPostsErrorState(errMessage: failure.errMessage)),
      (posts) {
        if (profileData != null) {
          myPostsList = posts.where((post) {
            return post.user.id.toString() == profileData!.id.toString();
          }).toList();
        } else {
          myPostsList = posts;
        }

        //  مزامنة العداد مع عدد عناصر القائمة الحقيقي
        _updateStatsFromPostsList();

        emit(GetMyPostsSuccessState(myPosts: List.from(myPostsList)));
      },
    );
  }

  Future<void> deletePost(int id) async {
  emit(DeletePostLoadingState());

  final result = await deletePostUseCase(id);

  result.fold(
    (failure) => emit(DeletePostErrorState(errMessage: failure.errMessage)),
    (_) {
      //  حذفه من قائمة البروفايل
      myPostsList.removeWhere((post) => post.id == id);
      _updateStatsFromPostsList();

      //  حذفه فوراً من قائمة الهوم بالذاكرة (إذا كان PostCubit متوفراً)
      // هذا السطر يضمن اختفاء المنشور من الهوم لحظياً
      emit(DeletePostSuccessState(deletedPostId: id));
      emit(GetMyPostsSuccessState(myPosts: List.from(myPostsList)));
    },
  );
}



  //  دالة داخلية لمزامنة أرقام العداد مع القائمة الحالية للمنشورات
  void _updateStatsFromPostsList() {
    if (profileData != null) {
      final currentCount = myPostsList.length;
      profileData = ProfileEntity(
        id: profileData!.id,
        name: profileData!.name,
        email: profileData!.email,
        stats: ProfileStatsEntity(
          postsCount: currentCount,
          publishedPosts: currentCount,
          drafts: profileData!.stats.drafts,
          commentsCount: profileData!.stats.commentsCount,
          likesCount: profileData!.stats.likesCount,
        ),
      );
    }
  }
}