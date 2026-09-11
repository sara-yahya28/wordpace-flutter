import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/post/presentation/cubit/post_cubit.dart';
import 'package:wordspace/features/post/presentation/cubit/post_state.dart';
import 'package:wordspace/features/post/presentation/screens/post_details_screen.dart';
import 'package:wordspace/features/post/presentation/widgets/post_card_widget.dart';
import 'package:wordspace/features/post/utils/date_formatter.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late ScrollController _scrollController;
  final Map<int, int> updatedCommentsCount = {};

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<PostCubit>().getPosts();
      }
    });

    context.read<PostCubit>().getPosts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordpace'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PostFailure) {
            return Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          if (state is PostSuccess ||
              state is PostLoadingMore ||
              state is PostAdded) {
            final posts = state is PostSuccess
                ? state.posts
                : state is PostLoadingMore
                    ? state.posts
                    : context.read<PostCubit>().posts;
                    
            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: posts.length + (state is PostLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final post = posts[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PostCardWidget(
                    post: post,
                    username: post.user.name,
                    time: formatPostTime(post.createdAt),
                    title: post.title,
                    content: post.content,
                    likes: post.likesCount,
                    comments:
                        updatedCommentsCount[post.id] ?? post.commentsCount,
                    isLiked: post.likedByMe,
                    onTap: () async {
                      final updatedCount = await Navigator.push<int>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsScreen(
                            post: post,
                          ),
                        ),
                      );

                      if (updatedCount != null) {
                        setState(() {
                          updatedCommentsCount[post.id] = updatedCount;
                        });
                      }
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
