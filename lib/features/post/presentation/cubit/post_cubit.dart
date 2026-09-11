import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
import 'package:wordspace/features/post/domain/usecases/get_posts_usecase.dart';
import 'post_state.dart';
import 'package:wordspace/features/post/domain/usecases/add_post_usecase.dart';

class PostCubit extends Cubit<PostState> {
  final GetPostsUseCase getPostsUseCase;
  final AddPostUseCase addPostUseCase;
  bool isLoading = false;

  PostCubit({
    required this.getPostsUseCase,
    required this.addPostUseCase,
  }) : super(PostInitial());

  int currentPage = 1;
  bool hasMore = true;

//نخزن كل المنشورات التي تم تحميلها في posts
  List<PostEntity> posts = [];

  Future<void> getPosts() async {
    if (!hasMore || isLoading) return;

    isLoading = true;

    if (currentPage == 1) {
      emit(PostLoading());
    } else {
      emit(
        PostLoadingMore(
          posts: posts,
        ),
      );
    }

//نستدعي الـUseCase للحصول على المنشورات حسب رقم الصفحة
    final result = await getPostsUseCase(currentPage);

    result.fold(
      (failure) {
        isLoading = false;

        emit(
          PostFailure(
            message: failure.errMessage,
          ),
        );
      },
      (response) {
        if (currentPage == 1) {
          posts = response.posts;
        } else {
          //نضيف المنشورات الجديدة إلى القائمة القديمة
          posts = [
            ...posts,
            ...response.posts,
          ];
        }

        currentPage = response.currentPage + 1;

        hasMore = response.currentPage < response.lastPage;

//نرسل الحالة الجديدة مع المنشورات التي تم تحميلها
        emit(
          PostSuccess(
            posts: posts,
            currentPage: response.currentPage,
            lastPage: response.lastPage,
          ),
        );

        isLoading = false;
      },
    );
  }

  Future<void> addPost({
    required String title,
    required String body,
    required String status,
  }) async {
    emit(PostAdding());

    final result = await addPostUseCase(
      title: title,
      body: body,
      status: status,
    );

    result.fold(
      (failure) {
        emit(PostAddFailure(message: failure.errMessage));
      },
      (post) {
        if (post.status == 'published') {
          posts = [post, ...posts];
        }

        emit(PostAdded(post: post));
      },
    );
  }
}
