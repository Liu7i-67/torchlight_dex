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
  List<PactspiritItemModel> _filteredLists = []; // 👈 过滤后的列表
  final TextEditingController _searchController =
      TextEditingController(); // 👈 搜索控制器
  final ScrollController _scrollController = ScrollController();

  // 加载 JSON
  Future<void> loadList() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/pactspirit_list.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);
    final loadedList = jsonList
        .map((j) => PactspiritItemModel.fromJson(j))
        .toList();
    setState(() {
      listsFuture = loadedList;
      _filteredLists = loadedList;
    });
  }

  void _onSearchChanged(String query) {
    final filtered = listsFuture.where((item) {
      final nameLower = item.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredLists = filtered;
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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: const InputDecoration(
            hintText: '搜索契约灵...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Stack(
        children: [
          _filteredLists.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _filteredLists.length,
                      padding: const EdgeInsets.only(
                        bottom: 90, // 👈 关键：留出足够空间给底部 FABs
                      ),
                      itemBuilder: (context, index) {
                        final item = _filteredLists[index];
                        return PactspiritListItem(item: item);
                      },
                    ),
                  ),
                ),
          ScrollToTopButton(scrollController: _scrollController),
        ],
      ),
    );
  }
}
