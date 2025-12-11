import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:torchlight_dex/components/scrollToTopButton/scroll_to_top_button.dart';
import 'package:torchlight_dex/pages/pactspirit/pactspirit_item_model.dart';
import 'package:torchlight_dex/pages/pactspirit/pactspirit_list_item.dart';
import 'package:torchlight_dex/pages/pactspirit/pactspirit_filter_drawer.dart';

String _extractSearchableText(PactspiritItemModel item) {
  final texts = <String>[item.name, item.tag, item.rarity, item.desc];

  // 遍历所有 modifier 行
  for (final line in item.modifier) {
    for (final part in line) {
      // 添加 content（必填）
      texts.add(part.content);
      // 添加 tips（可选）
      if (part.tips != null) {
        texts.add(part.tips!);
      }
    }
  }

  return texts.join(' '); // 用空格连接，避免跨字段粘连（如 "火灵" + "攻击" → "火灵 攻击"）
}

class PactspiritPage extends StatefulWidget {
  const PactspiritPage({super.key});

  @override
  State<PactspiritPage> createState() => _PactspiritPageState();
}

class _PactspiritPageState extends State<PactspiritPage> {
  List<PactspiritItemModel> listsFuture = [];
  List<PactspiritItemModel> _filteredLists = [];
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _selectedTag;
  String? _selectedRarity;
  Set<String> _allTags = {};
  Set<String> _allRarities = {};

  // 加载 JSON
  Future<void> loadList() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/pactspirit_list.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);
    final loadedList = jsonList
        .map((j) => PactspiritItemModel.fromJson(j))
        .toList();
    // 提取所有唯一 tag 和 rarity
    final tags = <String>{};
    final rarities = <String>{};
    for (final item in loadedList) {
      tags.add(item.tag);
      rarities.add(item.rarity);
    }
    setState(() {
      listsFuture = loadedList;
      _filteredLists = loadedList;
      _allTags = tags;
      _allRarities = rarities;
    });
  }

  void _applyFilters({String? searchQuery}) {
    String queryLower = (searchQuery ?? '').toLowerCase();

    final filtered = listsFuture.where((item) {
      final searchableText = _extractSearchableText(item).toLowerCase();
      // 搜索匹配
      bool matchesSearch = searchableText.contains(queryLower);

      // Tag 匹配（如果未选择，则视为通过）
      bool matchesTag = _selectedTag == null || item.tag == _selectedTag;

      // Rarity 匹配
      bool matchesRarity =
          _selectedRarity == null || item.rarity == _selectedRarity;

      return matchesSearch && matchesTag && matchesRarity;
    }).toList();

    setState(() {
      _filteredLists = filtered;
    });
  }

  void _onSearchChanged(String query) {
    _applyFilters(searchQuery: query);
  }

  void _resetFilters() {
    setState(() {
      _selectedTag = null;
      _selectedRarity = null;
    });
    _applyFilters(searchQuery: _searchController.text);
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
            hintText: '搜索契灵...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      endDrawer: PactspiritFilterDrawer(
        selectedTag: _selectedTag,
        selectedRarity: _selectedRarity,
        allTags: _allTags,
        allRarities: _allRarities,
        onTagSelected: (value) {
          setState(() {
            _selectedTag = value;
          });
          _applyFilters(searchQuery: _searchController.text);
        },
        onRaritySelected: (value) {
          setState(() {
            _selectedRarity = value;
          });
          _applyFilters(searchQuery: _searchController.text);
        },
        onResetFilters: () {
          _resetFilters(); // 它内部已调用 setState 和 _applyFilters
        },
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
