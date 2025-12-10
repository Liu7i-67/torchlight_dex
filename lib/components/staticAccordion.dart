import 'package:flutter/material.dart';

class StaticAccordion extends StatelessWidget {
  final List<AccordionItem> items;
  final EdgeInsetsGeometry contentPadding;

  /// 默认展开的索引（如 0 表示展开第一项）
  final int? initialIndex;

  const StaticAccordion({
    Key? key,
    required this.items,
    this.initialIndex,
    this.contentPadding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.zero,

      /// 默认展开项
      initialOpenPanelValue:
          (initialIndex != null &&
              initialIndex! >= 0 &&
              initialIndex! < items.length)
          ? items[initialIndex!].title
          : null,

      children: items.map((item) {
        return ExpansionPanelRadio(
          value: item.title,
          headerBuilder: (context, isExpanded) =>
              ListTile(title: Text(item.title)),
          body: Padding(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: item.contents.map((line) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• "),
                      Expanded(
                        child: Text(line, style: const TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// 手风琴单项（内容为数组）
class AccordionItem {
  final String title;
  final List<String> contents;

  AccordionItem({required this.title, required this.contents});
}
