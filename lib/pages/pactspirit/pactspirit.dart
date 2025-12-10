import 'package:flutter/material.dart';

class PactspiritPage extends StatefulWidget {
  const PactspiritPage({super.key});

  @override
  State<PactspiritPage> createState() => _PactspiritPageState();
}

class _PactspiritPageState extends State<PactspiritPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("Pactspirit")],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/',
            (route) => false, // 移除所有旧路由
          );
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
