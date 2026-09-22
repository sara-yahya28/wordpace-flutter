import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_cubit.dart';
import 'package:wordspace/features/user/presentation/cubit/user_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 3));
    if (!mounted) return;

    final userCubit = context.read<UserCubit>();

    if (userCubit.isAuthenticated()) {
      print('🔍 Splash: توكن موجود → Home');
      // جيبي إعجابات المستخدم قبل ما تروحي Home
      context.read<LikeCubit>().getFavoritePosts();
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print('🔍 Splash: مافي توكن → Welcome');
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
