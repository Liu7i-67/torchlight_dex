import 'package:torchlight_dex/components/modifierLineWidget/modifier_model.dart';

class PactspiritItemModel {
  final int index;
  final String name;
  final String key;
  final String tag;
  final String rarity;
  final String desc;
  final List<List<ModifierPart>> modifier;

  PactspiritItemModel({
    required this.index,
    required this.name,
    required this.key,
    required this.tag,
    required this.rarity,
    required this.desc,
    required this.modifier,
  });

  factory PactspiritItemModel.fromJson(Map<String, dynamic> json) {
    // 解析 modifier: List<List<Map>>
    final modifierJson = json['modifier'] as List?;
    final List<List<ModifierPart>> modifier = [];

    if (modifierJson != null) {
      for (final line in modifierJson) {
        final List<dynamic> lineList = List<dynamic>.from(line);
        final List<ModifierPart> parsedLine = lineList
            .map((part) => ModifierPart.fromJson(part as Map<String, dynamic>))
            .toList();
        modifier.add(parsedLine);
      }
    }

    return PactspiritItemModel(
      index: json['index'],
      name: json['name'],
      key: json['key'],
      tag: json['tag'],
      rarity: json['rarity'],
      desc: json['desc'],
      modifier: modifier,
    );
  }
}
