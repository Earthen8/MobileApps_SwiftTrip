class Language {
  final String flag;
  final String name;

  const Language({
    required this.flag,
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      flag: json['flag'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flag': flag,
      'name': name,
    };
  }
}
