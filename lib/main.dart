import 'package:flutter/material.dart';
import 'package:threads_logo_animation/splash.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Threads Logo Animation',
      themeMode: ThemeMode.dark,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF101010)),
      debugShowCheckedModeBanner: false,
      home: const SplashView(child: Scaffold()),
    );
  }
}
