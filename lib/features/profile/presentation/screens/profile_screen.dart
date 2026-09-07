import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_state.dart';
import 'package:wordspace/features/profile/presentation/widgets/my_posts_list_widget.dart';
import 'package:wordspace/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:wordspace/features/profile/presentation/widgets/profile_stats_bar_widget.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              // سيتم ربط حدث تسجيل الخروج لاحقاً
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (state is GetProfileErrorState) {
            return Center(child: Text(state.errMessage));
          }
           else if (state is GetProfileSuccessState) {
            final profile = state.profile;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  //  ودجت الصورة والمعلومات
                  ProfileHeaderWidget(
                    name: profile.name,
                    email: profile.email,
                  ),
                  const SizedBox(height: 24),

                  //  ودجت الأرقام والإحصائيات
                  ProfileStatsBarWidget(
                    stats: profile.stats,
                  ),
                  const SizedBox(height: 24),

                  const Divider(),
                  const SizedBox(height: 12),

                  // 3 عنوان قسم المنشورات تحته مباشرة
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

                  const MyPostsListWidget(),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}