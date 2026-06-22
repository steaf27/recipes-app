class Recipe {
  int id;
  String title;
  String description;
  String ingredients;
  String tools;
  String steps;
  String? image;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.tools,
    required this.steps,
    this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      ingredients: json['ingredients'] ?? '',
      tools: json['tools'] ?? '',
      steps: json['steps'] ?? '',
      image: json['image'],
    );
  }
}
