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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  for (final rarity in allRarities)
                    ChoiceChip(
                      label: Text(rarity),
                      selected: selectedRarity == rarity,
                      onSelected: (_) {
                        onRaritySelected(rarity);
                        Navigator.pop(context);
                      },
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  for (final tag in allTags)
                    ChoiceChip(
                      label: Text(tag),
                      selected: selectedTag == tag,
                      onSelected: (_) {
                        onTagSelected(tag);
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
