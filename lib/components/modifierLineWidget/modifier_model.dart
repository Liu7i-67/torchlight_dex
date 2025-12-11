class ModifierPart {
  final List<String> type; // 现在总是 List<String>
  final String content;
  final String? tips;

  ModifierPart({required this.type, required this.content, this.tips});

  factory ModifierPart.fromJson(Map<String, dynamic> json) {
    // 安全地读取 type 字段，确保它是 List<String>
    final typeList = (json['type'] as List?)?.cast<String>() ?? ['text'];

    return ModifierPart(
      type: typeList,
      content: json['content'] as String,
      tips: json['tips'] as String?,
    );
  }
}
