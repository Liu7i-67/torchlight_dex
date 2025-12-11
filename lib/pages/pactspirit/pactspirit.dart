import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:torchlight_dex/components/backToHome/back_to_home.dart';
import 'package:torchlight_dex/components/scrollToTopButton/scroll_to_top_button.dart';
import 'package:torchlight_dex/pages/pactspirit/pactspirit_item_model.dart';
import 'package:torchlight_dex/pages/pactspirit/pactspirit_list_item.dart';

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
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: listsFuture.length,
                      padding: const EdgeInsets.only(
                        bottom: 90, // 👈 关键：留出足够空间给底部 FABs
                      ),
                      itemBuilder: (context, index) {
                        final item = listsFuture[index];
                        return PactspiritListItem(item: item);
                      },
                    ),
                  ),
                ),
          const BackHomeButton(),
          ScrollToTopButton(scrollController: _scrollController),
        ],
      ),
    );
  }
}
