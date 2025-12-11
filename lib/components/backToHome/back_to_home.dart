import 'package:flutter/material.dart';

class BackHomeButton extends StatelessWidget {
  final VoidCallback? onPressed; // 允许自定义点击逻辑（可选）

  const BackHomeButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      bottom: 16,
      child: FloatingActionButton(
        heroTag: 'backHome', // 建议保留，避免多个 FAB 冲突
        onPressed:
            onPressed ??
            () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
        child: const Icon(Icons.home),
      ),
    );
  }
}
