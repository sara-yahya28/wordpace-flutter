import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/theme/app_theme.dart';
import 'package:wordspace/core/widgets/custom_snack_bar.dart';
import 'package:wordspace/features/likes/presentation/screens/favorits_screen.dart';
import 'package:wordspace/features/post/presentation/cubit/post_cubit.dart';
import 'package:wordspace/features/post/presentation/screens/add_post_screen.dart';
import 'package:wordspace/features/post/presentation/screens/post_screen.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:wordspace/features/profile/presentation/screens/profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      // 0: Home
      const PostScreen(),
      // 1: Add Post
      AddPostScreen(
        onPostAdded: () {
          // إعادة جلب منشورات الهوم
          context.read<PostCubit>().getPosts();

          //  إعادة جلب بيانات وإحصائيات البروفايل
          context.read<ProfileCubit>().getProfileStats();

          //  التنقل للبروفايل مباشرة
          setState(() {
            _currentIndex = 3;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.success(
              message: 'Post added successfully',
            ),
          );
        },
      ),
      // 2: Likes / Favorites
      const FavoritsScreen(),
      // 3: Profile
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.primaryDark,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.add_circle_outline_rounded,
                  label: 'Add',
                  index: 1,
                ),
                _buildNavItem(
                  icon: Icons.favorite_border_rounded,
                  label: 'Likes',
                  index: 2,
                ),
                _buildNavItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Profile',
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppTheme.backgroundColor : Colors.white60;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });

          //  عند الانتقال للهوم: إعادة جلب منشورات الهوم للتأكد من اختفاء المنشورات المحذوفة
          if (index == 0) {
            context.read<PostCubit>().getPosts();
          }
         

         
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 27,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}