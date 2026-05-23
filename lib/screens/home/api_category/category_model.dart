class CateogryModel {
  final String name;
  final String image;
  final String categoryId;
  final bool isActeve;
  final DateTime createdAt;
  CateogryModel({
    required this.createdAt,
    required this.name,
    required this.image,
    required this.categoryId,
    required this.isActeve,
  });
  factory CateogryModel.fromJson(Map<String, dynamic> json, String docID) {
    return CateogryModel(
      createdAt: DateTime.now(),
      name: json['Name'] ?? '',
      image: json['image'] ?? '',
      categoryId: docID,
      isActeve: json['IS_Active'] ?? true,
    );
  }
}
