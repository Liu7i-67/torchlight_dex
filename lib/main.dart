import 'package:flutter/material.dart';
import 'package:torchlight_dex/pages/detail/detail.dart';
import 'package:torchlight_dex/pages/home/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "火炬之光",
      initialRoute: "/",
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => DetailPage(),
      },
    );
  }
}
