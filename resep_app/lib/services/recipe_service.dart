import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/recipe_model.dart';
import 'auth_service.dart';

class RecipeService {

  static const String baseUrl =
      'http://10.0.2.2:8000/api';

  static Future<List<Recipe>>
  getRecipes() async {

    final token =
    await AuthService.getToken();

    final response = await http.get(

      Uri.parse('$baseUrl/recipes'),

      headers: {

        'Authorization':
        'Bearer $token',

        'Accept':
        'application/json',
      },
    );

    final List data =
    jsonDecode(response.body);

    return data.map((e) =>
        Recipe.fromJson(e)).toList();
  }
}