class Foods {
  String name;

  Foods({this.name});

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(name: json['name']);
  }
}