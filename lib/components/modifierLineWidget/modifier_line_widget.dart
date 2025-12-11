import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:torchlight_dex/components/modifierLineWidget/modifier_model.dart';

class ModifierLineWidget extends StatelessWidget {
  final List<ModifierPart> parts;

  const ModifierLineWidget({super.key, required this.parts});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: parts.map((part) {
          final style = _resolveStyle(context, part.type);
          return TextSpan(
            text: part.content,
            style: style.textStyle,
            recognizer: part.tips != null
                ? (TapGestureRecognizer()
                    ..onTap = () => _showTip(context, part.tips!))
                : null,
          );
        }).toList(),
      ),
    );
  }

  // 👇 根据 type 列表解析出最终的 TextStyle 和交互行为
  _ResolvedStyle _resolveStyle(BuildContext context, List<String> types) {
    Color? color;
    FontWeight fontWeight = FontWeight.normal;

    // 按照你希望的优先级顺序处理（后面的会覆盖前面的）
    for (final type in types) {
      switch (type.toLowerCase()) {
        case 'text-mod':
          color = const Color.fromARGB(255, 132, 255, 22);
          break;
        case 'hyperlink':
          color = const Color.fromARGB(255, 0, 255, 255);
          break;
        case 'text':
        default:
          // 默认颜色：使用主题文本颜色
          color = Colors.white;
      }
    }

    return _ResolvedStyle(
      textStyle: TextStyle(color: color, fontWeight: fontWeight, fontSize: 14),
    );
  }

  void _showTip(BuildContext context, String tip) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(tip), duration: const Duration(seconds: 2)),
    );
  }
}

// 辅助类，用于返回样式（也可直接返回 TextStyle，但留扩展空间）
class _ResolvedStyle {
  final TextStyle textStyle;
  const _ResolvedStyle({required this.textStyle});
}
