import 'package:flutter/material.dart';
import 'package:wordspace/core/di/injection.dart';
import 'package:wordspace/core/theme/app_theme.dart';
import 'package:wordspace/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordSpace',
      theme: AppTheme.lightTheme,
      home: HomePage(), 
    );
  }
}