import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wordspace/core/di/injection.dart';
import 'package:wordspace/core/theme/app_theme.dart';
import 'package:wordspace/main_layout_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WordSpace',
      theme: AppTheme.lightTheme,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
     home: const MainLayoutScreen(),
    );
  }
}