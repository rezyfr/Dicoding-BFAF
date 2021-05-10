class Drinks {
  String name;

  Drinks({this.name});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(name: json['name']);
  }
}