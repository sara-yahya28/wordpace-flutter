import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/di/injection.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:wordspace/features/profile/presentation/screens/profile_screen.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 3; //(اغير للهوم بعدين) يفتح افتراضياً على شاشة البروفايل

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      // الرئيسية
      const Center(child: Text('Home Screen', style: TextStyle(fontSize: 20))),
      
      //  إضافة منشور
      const Center(child: Text('Add Post Screen', style: TextStyle(fontSize: 20))),
      
      //  الإعجابات
      const Center(child: Text('Likes Screen', style: TextStyle(fontSize: 20))),

      //  البروفايل
      BlocProvider(
        create: (context) => sl<ProfileCubit>()..getProfileStats(),
        child: const ProfileScreen(),
      ),
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
                //  الصفحة الرئيسية
                _buildNavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  index: 0,
                ),
                // إضافة منشور
                _buildNavItem(
                  icon: Icons.add_circle_outline_rounded,
                  label: 'Add',
                  index: 1,
                ),
                //  الإعجابات
                _buildNavItem(
                  icon: Icons.favorite_border_rounded,
                  label: 'Likes',
                  index: 2,
                ),
                //  البروفايل
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
//تنسيقات الايقونه والنص
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
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