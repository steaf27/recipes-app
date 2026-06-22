import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/favorite_model.dart';
import 'auth_service.dart';

class FavoriteService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // Ambil semua favorit
  static Future<List<Favorite>> getFavorites() async {
    String? token = await AuthService.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/favorites"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((e) => Favorite.fromJson(e)).toList();
    }

    return [];
  }

  // Tambah favorit
  static Future<bool> addFavorite(int recipeId) async {
    String? token = await AuthService.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/favorites"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
      body: {"recipe_id": recipeId.toString()},
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  // Hapus favorit
  static Future<bool> removeFavorite(int favoriteId) async {
    String? token = await AuthService.getToken();

    final response = await http.delete(
      Uri.parse("$baseUrl/favorites/$favoriteId"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    return response.statusCode == 200;
  }
}
