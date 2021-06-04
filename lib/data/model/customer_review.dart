class CustomerReview {
  CustomerReview({
    this.name,
    this.review,
    required this.date,
  });

  String? name;
  String? review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );
}

Map<String, dynamic> toJson(String id, String name, String review) => {
  "name": name,
  "review": review,
  "id": id,
};