import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final ScrollController _scrollController = ScrollController();

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demo 页面")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 50,
        itemBuilder: (_, index) => ListTile(title: Text("项目 $index")),
      ),

      // 用 Stack 实现多个浮动按钮
      floatingActionButton: Stack(
        children: [
          // 左侧返回按钮
          Positioned(
            left: 20, // 这里不会再“贴边”
            bottom: 20,
            child: FloatingActionButton(
              heroTag: "back_button", // 多按钮必填，防止 tag 冲突
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.home),
            ),
          ),

          // 右侧滚动到顶部按钮
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: "top_button",
              onPressed: scrollToTop,
              child: const Icon(Icons.arrow_upward),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
