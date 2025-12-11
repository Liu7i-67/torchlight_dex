import 'package:flutter/material.dart';

class PactspiritFilterDrawer extends StatelessWidget {
  final String? selectedTag;
  final String? selectedRarity;
  final Set<String> allTags;
  final Set<String> allRarities;
  final ValueChanged<String?> onTagSelected;
  final ValueChanged<String?> onRaritySelected;
  final VoidCallback onResetFilters;

  const PactspiritFilterDrawer({
    super.key,
    required this.selectedTag,
    required this.selectedRarity,
    required this.allTags,
    required this.allRarities,
    required this.onTagSelected,
    required this.onRaritySelected,
    required this.onResetFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  onResetFilters();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('重置筛选'),
              ),
            ),

            // Rarity 筛选
            ListTile(
              title: const Text('稀有度 (Rarity)'),
              subtitle: Text(selectedRarity ?? '未选择'),
            ),
            RadioGroup<String>(
              groupValue: selectedRarity,
              onChanged: (String? value) {
                onRaritySelected(value);
                Navigator.pop(context);
              },
              child: Column(
                children: [
                  for (final rarity in allRarities)
                    RadioListTile<String>(
                      title: Text(rarity),
                      value: rarity,
                      // groupValue 和 onChanged 由 RadioGroup 提供，无需重复
                    ),
                ],
              ),
            ),

            const Divider(),

            // Tag 筛选
            ListTile(
              title: const Text('标签 (Tag)'),
              subtitle: Text(selectedTag ?? '未选择'),
            ),
            RadioGroup<String>(
              groupValue: selectedTag,
              onChanged: (String? value) {
                onTagSelected(value);
                Navigator.pop(context);
              },
              child: Column(
                children: [
                  for (final tag in allTags)
                    RadioListTile<String>(title: Text(tag), value: tag),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
