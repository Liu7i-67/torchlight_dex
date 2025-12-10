import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:torchlight_dex/pages/pactspirit/pactspirit_item.dart';

class PactspiritPage extends StatefulWidget {
  const PactspiritPage({super.key});

  @override
  State<PactspiritPage> createState() => _PactspiritPageState();
}

class _PactspiritPageState extends State<PactspiritPage> {
  List<PactspiritItemModel> listsFuture = [];

  // 正确定义 ScrollController
  final ScrollController _scrollController = ScrollController();

  // 加载 JSON
  Future<void> loadList() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/pactspirit_list.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);

    setState(() {
      listsFuture = jsonList
          .map((j) => PactspiritItemModel.fromJson(j))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          listsFuture.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: listsFuture.length,
                      padding: const EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 90, // 👈 关键：留出足够空间给底部 FABs
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 3 / 2,
                          ),
                      itemBuilder: (context, index) {
                        final item = listsFuture[index];
                        String imagePath =
                            'assets/images/pactspirit/${item.key}.webp';
                        return Card(
                          elevation: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    imagePath,
                                    fit: BoxFit.fitHeight,
                                    // 使用默认背景色作为占位符
                                    frameBuilder:
                                        (
                                          BuildContext context,
                                          Widget child,
                                          int? frame,
                                          bool wasSynchronouslyLoaded,
                                        ) {
                                          if (wasSynchronouslyLoaded ||
                                              frame != null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          item.tag,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          item.rarity,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFFFF5722),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // 👇 新增：渲染 modifier 内容（纯文本）
                                    ...item.modifier.map((line) {
                                      // 拼接这一行的所有 content
                                      final lineText = line
                                          .map((part) => part.content)
                                          .join('');
                                      return Text(lineText);
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
          // 左下角返回按钮
          Positioned(
            left: 16,
            bottom: 16,
            child: FloatingActionButton(
              heroTag: "backHome",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false, // 移除所有旧路由
                );
              },
              child: const Icon(Icons.home),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              heroTag: "top",
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              child: const Icon(Icons.vertical_align_top),
            ),
          ),
        ],
      ),
    );
  }
}
