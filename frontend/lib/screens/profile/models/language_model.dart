class Language {
  final String code;
  final String flag;
  final String name;

  const Language({required this.code, required this.flag, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: json['code'] ?? 'en',
      flag: json['flag'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'flag': flag, 'name': name};
  }
}
