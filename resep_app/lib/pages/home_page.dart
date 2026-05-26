import 'package:flutter/material.dart';

import '../models/recipe_model.dart';
import '../services/recipe_service.dart';
import 'login_page.dart';
import '../services/auth_service.dart';
import 'add_recipe_page.dart';
import 'edit_recipe_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchRecipes();
  }

  void fetchRecipes() async {
    recipes = await RecipeService.getRecipes();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteRecipe(int id) async {
    String? token = await AuthService.getToken();

    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/api/recipes/$id'),

      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      fetchRecipes();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Resep berhasil dihapus')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,

        title: const Text(
          'Daftar Resep',

          style: TextStyle(color: Colors.white),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),

            onPressed: () async {
              await AuthService.logout();

              Navigator.pushReplacement(
                context,

                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : recipes.isEmpty
          ? const Center(child: Text('Belum ada resep'))
          : ListView.builder(
              padding: const EdgeInsets.all(15),

              itemCount: recipes.length,

              itemBuilder: (context, index) {
                final recipe = recipes[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,

                        blurRadius: 5,

                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),

                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,

                      child: Text(
                        recipe.title[0].toUpperCase(),

                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                    title: Text(
                      recipe.title,

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,

                        fontSize: 18,
                      ),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),

                      child: Text(recipe.description),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),

                          onPressed: () async {
                            final result = await Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) => EditRecipePage(recipe: recipe),
                              ),
                            );

                            if (result == true) {
                              fetchRecipes();
                            }
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),

                          onPressed: () {
                            showDialog(
                              context: context,

                              builder: (_) => AlertDialog(
                                title: const Text('Konfirmasi'),

                                content: const Text(
                                  'Yakin ingin menghapus resep ini?',
                                ),

                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },

                                    child: const Text('Batal'),
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      deleteRecipe(recipe.id);
                                    },

                                    child: const Text('Hapus'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),

        child: const Icon(Icons.add),

        onPressed: () async {
          final result = await Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const AddRecipePage()),
          );

          if (result == true) {
            fetchRecipes();
          }
        },
      ),
    );
  }
}
