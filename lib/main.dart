import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wordspace/core/di/injection.dart';
import 'package:wordspace/core/theme/app_theme.dart';
import 'package:wordspace/features/user/presentation/cubit/user_cubit.dart';
import 'package:wordspace/features/user/presentation/screens/login_screen.dart';
import 'package:wordspace/features/user/presentation/screens/register_screen.dart';
import 'package:wordspace/features/user/presentation/screens/welcome_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

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
    final cubit = sl<UserCubit>();
    print('UserCubit is ready: ${cubit.runtimeType}');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WordSpace',
      theme: AppTheme.lightTheme,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // home: RegisterScreen(), // <-- replace this
      home: const WelcomeScreen(), // <-- new home
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}