import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    // 接收路由参数
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final id = args['id'];
    final title = args['title'];

    return Scaffold(
      appBar: AppBar(title: const Text("详情页")),
      body: Center(
        child: Column(
          children: [
            Text("ID: $id\n标题: $title"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 返回
              },
              child: const Text("返回"),
            ),
            const SizedBox(height: 20),
            Text("计数器：$counter", style: TextStyle(fontSize: 26)),

            const SizedBox(height: 30),
            // 加一
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const Text("加 1"),
            ),
            const SizedBox(height: 10),

            // 重置
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter = 0;
                });
              },
              child: const Text("重置"),
            ),
          ],
        ),
      ),
    );
  }
}
