class CategorieModel {
  final int id;
  final String name;
  final String image;

  CategorieModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) {
    return CategorieModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
