import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/di/injection.dart' as di;
import 'package:wordspace/core/theme/app_theme.dart';
import 'package:wordspace/features/post/presentation/cubit/post_cubit.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:wordspace/features/user/presentation/cubit/user_cubit.dart';
import 'package:wordspace/features/user/presentation/screens/login_screen.dart';
import 'package:wordspace/features/user/presentation/screens/register_screen.dart';
import 'package:wordspace/features/user/presentation/screens/welcome_screen.dart';
import 'package:wordspace/main_layout_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => di.sl<UserCubit>()..isAuthenticated(),
        ),
        BlocProvider<PostCubit>(
          create: (context) => di.sl<PostCubit>()..getPosts(), // استخدم الدالة الموجودة
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => di.sl<ProfileCubit>()..getProfileStats(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WordSpace',
        theme: AppTheme.lightTheme,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: const WelcomeScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const MainLayoutScreen(),
        },
      ),
    );
  }
}