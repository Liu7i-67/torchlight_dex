class PactspiritItemModel {
  final int index;
  final String name;
  final String key;
  final String tag;
  final String rarity;
  final String desc;

  PactspiritItemModel({
    required this.index,
    required this.name,
    required this.key,
    required this.tag,
    required this.rarity,
    required this.desc,
  });

  factory PactspiritItemModel.fromJson(Map<String, dynamic> json) {
    return PactspiritItemModel(
      index: json['index'],
      name: json['name'],
      key: json['key'],
      tag: json['tag'],
      rarity: json['rarity'],
      desc: json['desc'],
    );
  }
}
