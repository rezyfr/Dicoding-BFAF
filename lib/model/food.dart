class Foods {
  String name;

  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(name: json['name']);
  }
}