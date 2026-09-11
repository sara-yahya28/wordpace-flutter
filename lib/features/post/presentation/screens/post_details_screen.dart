import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/di/injection.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
import 'package:wordspace/features/post/presentation/cubit/comment_cubit.dart';
import 'package:wordspace/features/post/presentation/cubit/comment_state.dart';
import 'package:wordspace/features/post/presentation/widgets/add_comment_widget.dart';
import 'package:wordspace/features/post/presentation/widgets/comment_item_widget.dart';
import 'package:wordspace/features/post/presentation/widgets/post_details_widget.dart';
import 'package:wordspace/features/post/utils/date_formatter.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostEntity post;

  const PostDetailsScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CommentCubit>()..getComments(post.id),
      child: Builder(
        builder: (context) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;

              final commentsCount =
                  context.read<CommentCubit>().comments.length;

              Navigator.pop(context, commentsCount);
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Post Details'),
                automaticallyImplyLeading: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostDetailsWidget(
                        username: post.user.name,
                        time: formatPostTime(post.createdAt),
                        title: post.title,
                        content: post.content,
                        likes: post.likesCount,
                        comments: post.commentsCount,
                        post: post,
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 24),

                      BlocBuilder<CommentCubit, CommentState>(
                        builder: (context, state) {
                          final commentsCount =
                              context.read<CommentCubit>().comments.length;

                          return Text(
                            'Comments ($commentsCount)',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      BlocBuilder<CommentCubit, CommentState>(
                        builder: (context, state) {
                          if (state is CommentLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is CommentFailure) {
                            return Center(
                              child: Text(state.message),
                            );
                          }

                          if (state is CommentSuccess) {
                            if (state.comments.isEmpty) {
                              return const Center(
                                child: Text('No comments yet'),
                              );
                            }

                            return Column(
                              children: state.comments.map((comment) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 16,
                                  ),
                                  child: CommentItemWidget(
                                    username: comment.userName,
                                    time: formatPostTime(
                                      comment.createdAt,
                                    ),
                                    comment: comment.content,
                                  ),
                                );
                              }).toList(),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              bottomSheet: BlocBuilder<CommentCubit, CommentState>(
                builder: (context, state) {
                  final isLoading = state is CommentAdding;

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 35,
                    ),
                    child: AddCommentWidget(
                      isLoading: isLoading,
                      onSend: (body) {
                        context.read<CommentCubit>().addComment(
                              post.id,
                              body,
                            );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}