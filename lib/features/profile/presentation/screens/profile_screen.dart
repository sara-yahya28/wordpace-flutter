import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/theme/app_theme.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_cubit.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_state.dart';
import 'package:wordspace/features/profile/presentation/widgets/my_posts_list_widget.dart';
import 'package:wordspace/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:wordspace/features/profile/presentation/widgets/profile_stats_bar_widget.dart';
import 'package:wordspace/features/user/presentation/cubit/user_cubit.dart';
import 'package:wordspace/features/user/presentation/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<ProfileCubit>();
      if (cubit.profileData == null) {
        cubit.getProfileStats();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              await context.read<UserCubit>().logout();

              if (!context.mounted) return;

              context.read<LikeCubit>().reset();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);

          //  حالة التحميل لأول مرة فقط (عند فتح التطبيق)
          if (state is GetProfileLoadingState && cubit.profileData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          //  حالة الخطأ لأول مرة فقط
          if (state is GetProfileErrorState && cubit.profileData == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errMessage),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      cubit.getProfileStats();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          final profile = cubit.profileData;

          if (profile == null) {
            return const SizedBox();
          }

          //  عرض البيانات بثبات مع ميزة RefreshIndicator للتحديث السلس عند السحب
          return RefreshIndicator(
            onRefresh: () async {
              await cubit.getProfileStats();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProfileHeaderWidget(
                    name: profile.name,
                    email: profile.email,
                  ),
                  const SizedBox(height: 24),
                  ProfileStatsBarWidget(
                    stats: profile.stats,
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'My Posts',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppTheme.primaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (state is GetMyPostsLoadingState && cubit.myPostsList.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    MyPostsListWidget(posts: cubit.myPostsList),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}