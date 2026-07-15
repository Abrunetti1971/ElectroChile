import 'package:flutter/material.dart';

import '../screens/splash/splash_screen.dart';
import 'theme.dart';

class ElectroChileApp extends StatelessWidget {
  const ElectroChileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElectroChile',
      debugShowCheckedModeBanner: false,

      theme: ECTheme.light,

      home: const SplashScreen(),
    );
  }
}