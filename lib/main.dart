import 'package:flutter/material.dart';
import 'package:simple_design/router.dart';
import 'package:simple_design/simple_design.dart';

void main() {
  runApp(const SimpleApp());
}

class SimpleApp extends StatelessWidget {
  const SimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Simple Design',
      debugShowCheckedModeBanner: false,
      theme: SDTheme.light,
      darkTheme: SDTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
