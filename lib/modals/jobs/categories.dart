class Category {
  String category;

  Category({
    required this.category,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
      };
}
