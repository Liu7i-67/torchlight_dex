import 'package:flutter/material.dart';
import 'package:torchlight_dex/components/staticAccordion.dart';

class ChangeLogPage extends StatefulWidget {
  const ChangeLogPage({super.key});

  @override
  State<ChangeLogPage> createState() => _ChangeLogPageState();
}

class _ChangeLogPageState extends State<ChangeLogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("更新日志")),
      body: ListView(
        children: [
          StaticAccordion(
            initialIndex: 0,
            items: [
              AccordionItem(
                title: "v0.0.1    2025-12-10",
                contents: ["支持查看契灵信息"],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
