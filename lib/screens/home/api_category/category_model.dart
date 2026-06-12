class CateogryModel {
  final String name;
  final String? nameAr;
  final String? nameEn;

  final String image;
  final String categoryId;
  final bool isActeve;
  final DateTime createdAt;

  CateogryModel({
    required this.createdAt,
    required this.name,
    this.nameAr,
    this.nameEn,
    required this.image,
    required this.categoryId,
    required this.isActeve,
  });

  factory CateogryModel.fromJson(Map<String, dynamic> json, String docID) {
    return CateogryModel(
      createdAt: DateTime.now(),
      name: json['Name'] ?? '',
      nameAr: json['nameAr'], // جديد
      nameEn: json['nameEn'], // جديد
      image: json['Image_URL'] ?? '',
      categoryId: docID,
      isActeve: json['IS_Active'] ?? true,
    );
  }
}
