class CateogryModel {
  final String name;
  final String image;
  final String categoryId;
  final bool isActeve;
  CateogryModel({
    required this.name,
    required this.image,
    required this.categoryId,
    required this.isActeve,
  });
  factory CateogryModel.fromJson(Map<String, dynamic> json, String docID) {
    return CateogryModel(
      name: json['Name'] ?? '',
      image: json['image'] ?? '',
      categoryId: docID,
      isActeve: json['IS_Active'] ?? true,
    );
  }
}
