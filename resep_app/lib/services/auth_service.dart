import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static const String baseUrl =
      'http://10.0.2.2:8000/api';

  static Future<bool> login(
      String email,
      String password,
      ) async {

    final response = await http.post(

      Uri.parse('$baseUrl/login'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({

        'email': email,
        'password': password,

      }),
    );

    final data =
    jsonDecode(response.body);

    if (response.statusCode == 200) {

      SharedPreferences prefs =
      await SharedPreferences.getInstance();

      await prefs.setString(
        'token',
        data['token'],
      );

      return true;
    }

    return false;
  }

  static Future<String?> getToken() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    return prefs.getString('token');
  }
}