import 'package:flutter/material.dart';
import 'package:torchlight_dex/components/backToHome/back_to_home.dart';
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
      body: ListView(
        children: [
          StaticAccordion(
            initialIndex: 0,
            items: [
              AccordionItem(
                title: "v0.0.2    2025-12-11",
                contents: ["完善了契灵信息的展示样式", '支持搜索契灵信息', '支持根据稀有度和标签去搜索契灵'],
              ),
              AccordionItem(
                title: "v0.0.1    2025-12-10",
                contents: ["支持查看契灵信息"],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: const BackHomeButton(),
    );
  }
}
