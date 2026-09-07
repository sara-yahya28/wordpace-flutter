import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/params/params.dart';
import 'package:wordspace/features/profile/domain/entities/profile_entity.dart';
import 'package:wordspace/features/profile/domain/usecases/get_profile_stats_usecase.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileStatsUseCase getProfileStatsUseCase;

  ProfileCubit({required this.getProfileStatsUseCase}) : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  Future<void> getProfileStats() async {
    emit(GetProfileLoadingState());

    // --- بيانات وهمية مؤقتة لمعاينة الواجهة ---
    await Future.delayed(const Duration(milliseconds: 500));
    emit(
      GetProfileSuccessState(
        profile: ProfileEntity(
          name: 'Fatma',
          email: 'fatma@example.com',
          stats: ProfileStatsEntity(
            postsCount: 8,
            likesCount: 5,
            commentsCount: 3,
            publishedPosts: 8,
            drafts: 0,
          ), id: 0,
        ),
      ),
    );

    /* 
    // الكود الأصلي للاتصال بالسيرفر (يتم تفعيله بعد إعادة شغل الـ API)
    final result = await getProfileStatsUseCase(const GetProfileStatsParams());

    result.fold(
      (failure) => emit(GetProfileErrorState(errMessage: failure.errMessage)),
      (profile) => emit(GetProfileSuccessState(profile: profile)),
    );
    */
  }
}