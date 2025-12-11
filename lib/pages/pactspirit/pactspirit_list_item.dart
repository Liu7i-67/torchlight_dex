import 'package:flutter/material.dart';
import 'package:torchlight_dex/components/modifierLineWidget/modifier_line_widget.dart';
import 'package:torchlight_dex/pages/pactspirit/pactspirit_item_model.dart';

class PactspiritListItem extends StatelessWidget {
  final PactspiritItemModel item;

  const PactspiritListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    String imagePath = 'assets/images/pactspirit/${item.key}.webp';
    Color? color;

    // 按照你希望的优先级顺序处理（后面的会覆盖前面的）

    switch (item.rarity) {
      case '魔法':
        color = const Color.fromARGB(255, 135, 206, 250);
        break;
      case '稀有':
        color = const Color.fromARGB(255, 152, 16, 213);
        break;
      case '传奇':
        color = const Color.fromARGB(255, 248, 188, 48);
        break;
      default:
        // 默认颜色：使用主题文本颜色
        color = Colors.white;
    }

    return Card(
      elevation: 3,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fitHeight,
                  frameBuilder:
                      (
                        BuildContext context,
                        Widget child,
                        int? frame,
                        bool wasSynchronouslyLoaded,
                      ) {
                        if (wasSynchronouslyLoaded || frame != null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 61, 59, 59),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(fontSize: 18, color: color),
                    ),
                    Row(
                      children: [
                        Text(
                          item.tag,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.rarity,
                          style: TextStyle(fontSize: 16, color: color),
                        ),
                      ],
                    ),
                    Text(
                      item.desc,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    // 渲染 modifier 的每一行
                    for (final line in item.modifier)
                      ModifierLineWidget(parts: line),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
