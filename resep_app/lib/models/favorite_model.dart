import 'recipe_model.dart';

class Favorite {
  final int id;
  final Recipe recipe;

  Favorite({required this.id, required this.recipe});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(id: json['id'], recipe: Recipe.fromJson(json['recipe']));
  }
}
