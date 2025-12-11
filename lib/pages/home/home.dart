import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("首页")),
      body: SizedBox.expand(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('欢迎使用'),
              const SizedBox(height: 20),
              Text('看看侧边栏'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              // 上部可滚动区域
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '菜单',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('首页'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.workspaces_outlined),
                        title: const Text('契灵'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/pactspirit');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.info),
                        title: const Text('更新日志'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/changelog');
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // 底部版本号
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '版本号 0.0.2',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
