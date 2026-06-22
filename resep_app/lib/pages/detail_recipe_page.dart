import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class DetailRecipePage extends StatelessWidget {
  final Recipe recipe;

  const DetailRecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F0FF),

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Detail Resep",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// Gambar
            if (recipe.image != null)
              Image.network(
                "http://10.0.2.2:8000/storage/${recipe.image}",
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),

            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// Judul
                  Text(
                    "🍽 ${recipe.title}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Deskripsi
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    recipe.description,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  ),

                  const SizedBox(height: 25),

                  /// Bahan
                  const Text(
                    "🥬 Bahan-bahan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    recipe.ingredients,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 25),

                  /// Alat
                  const Text(
                    "🔪 Alat",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(recipe.tools, style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 25),

                  /// Langkah
                  const Text(
                    "👨‍🍳 Langkah-langkah",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(recipe.steps, style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(Icons.arrow_back, color: Colors.white),

                      label: const Text(
                        "Kembali",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
