import 'package:flutter/material.dart';
import 'package:threads_logo_animation/splash.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      child: MaterialApp(
        title: 'Threads Clone',

        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const SplashView(
          child: Scaffold(body: Center(child: Text('Animation'))),
        ),
      ),
    );
  }
}
