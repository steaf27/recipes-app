import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/recipe_model.dart';
import '../services/auth_service.dart';
import '../services/recipe_service.dart';
import 'add_recipe_page.dart';
import 'detail_recipe_page.dart';
import 'edit_recipe_page.dart';
import 'login_page.dart';
// PASTIKAN INI ADA
import 'favorite_page.dart';

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
      backgroundColor: const Color(0xffF5F0FF),

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "🍽 ResepKita",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        actions: [
          // FAVORITE BUTTON
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritePage()),
              );
            },
          ),

          // LOGOUT BUTTON
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
          ? const Center(
              child: Text("Belum ada resep", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailRecipePage(recipe: recipe),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (recipe.image != null)
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: Image.network(
                                "http://10.0.2.2:8000/storage/${recipe.image}",
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 220,
                                    color: Colors.grey.shade300,
                                    child: const Center(
                                      child: Icon(Icons.image, size: 70),
                                    ),
                                  );
                                },
                              ),
                            ),

                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipe.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recipe.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                const SizedBox(height: 20),

                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DetailRecipePage(recipe: recipe),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "Detail Resep",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        // nanti bisa tambah fitur favorite
                                      },
                                    ),

                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                EditRecipePage(recipe: recipe),
                                          ),
                                        );

                                        if (result == true) {
                                          fetchRecipes();
                                        }
                                      },
                                    ),

                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text("Konfirmasi"),
                                            content: const Text(
                                              "Yakin ingin menghapus resep ini?",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Batal"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  deleteRecipe(recipe.id);
                                                },
                                                child: const Text("Hapus"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRecipePage()),
          );

          if (result == true) {
            fetchRecipes();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
