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
      appBar: AppBar(title: Text("更新日志")),
      body: ListView(
        children: [
          StaticAccordion(
            initialIndex: 0,
            items: [
              AccordionItem(
                title: "v0.0.3    2025-12-11",
                contents: ["移除更新日志页面的返回首页按钮组件，改用标题返回形式"],
              ),
              AccordionItem(
                title: "v0.0.2    2025-12-11",
                contents: [
                  "完善了契灵信息的展示样式",
                  '支持搜索契灵信息',
                  '支持根据稀有度和标签去搜索契灵',
                  '调整了打包后的应用名称',
                  '修改了打包后的应用图标',
                ],
              ),
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
