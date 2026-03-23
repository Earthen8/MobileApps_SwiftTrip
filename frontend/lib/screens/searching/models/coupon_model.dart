class CouponModel {
  final String title;
  final String description;
  final String code;

  const CouponModel({
    required this.title,
    required this.description,
    required this.code,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        title: json['title'] as String,
        description: json['description'] as String,
        code: json['code'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'code': code,
      };
}

