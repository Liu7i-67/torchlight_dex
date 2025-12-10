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

class ModifierPart {
  final List<String> type; // 注意：type 可能是字符串或字符串数组，如 "text" 或 ["text-mod"]
  final String content;
  final String? tips; // 可选字段

  ModifierPart({required this.type, required this.content, this.tips});

  factory ModifierPart.fromJson(Map<String, dynamic> json) {
    dynamic typeField = json['type'];

    List<String> typeList;
    if (typeField is String) {
      typeList = [typeField];
    } else if (typeField is List) {
      typeList = (typeField).cast<String>();
    } else {
      typeList = ['unknown'];
    }

    return ModifierPart(
      type: typeList,
      content: json['content'] as String,
      tips: json['tips'] as String?, // 安全处理可选字段
    );
  }
}
