import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<List<Recipe>> getRecipes() async {
    final response = await http.get(Uri.parse("$baseUrl/recipes"));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => Recipe.fromJson(e)).toList();
    }

    throw Exception("Gagal mengambil data");
  }
}
