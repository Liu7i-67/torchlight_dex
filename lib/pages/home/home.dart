import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("首页")),
      body: Center(
        child: Column(
          children: [
            Text('火炬之光22!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: {'id': 123, "title": "查询"},
                );
              },
              child: const Text("进入详情页"),
            ),
          ],
        ),
      ),
      drawer: Drawer(child: Center(child: Text('侧边栏'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('啊哈');
        },
        child: const Icon(Icons.brightness_7_outlined),
      ),
    );
  }
}
