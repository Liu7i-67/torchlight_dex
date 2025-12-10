class HeroModel {
  final int id;
  final String name;
  final int power;

  HeroModel({required this.id, required this.name, required this.power});

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(id: json['id'], name: json['name'], power: json['power']);
  }
}
