import 'package:flutter/material.dart';

import '../models/recipe_model.dart';
import '../services/recipe_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {

  List<Recipe> recipes = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchRecipes();
  }

  void fetchRecipes() async {

    recipes =
    await RecipeService.getRecipes();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      Colors.grey.shade100,

      appBar: AppBar(

        backgroundColor:
        Colors.deepPurple,

        title: const Text(

          'Daftar Resep',

          style: TextStyle(
            color: Colors.white,
          ),
        ),

        centerTitle: true,
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : recipes.isEmpty

          ? const Center(
        child:
        Text('Belum ada resep'),
      )

          : ListView.builder(

        padding:
        const EdgeInsets.all(15),

        itemCount: recipes.length,

        itemBuilder:
            (context, index) {

          final recipe =
          recipes[index];

          return Container(

            margin:
            const EdgeInsets.only(
              bottom: 15,
            ),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(20),

              boxShadow: [

                BoxShadow(

                  color:
                  Colors.black12,

                  blurRadius: 5,

                  offset:
                  const Offset(0, 3),
                ),
              ],
            ),

            child: ListTile(

              contentPadding:
              const EdgeInsets.all(15),

              leading: CircleAvatar(

                backgroundColor:
                Colors.deepPurple,

                child: Text(

                  recipe.title[0]
                      .toUpperCase(),

                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              title: Text(

                recipe.title,

                style: const TextStyle(

                  fontWeight:
                  FontWeight.bold,

                  fontSize: 18,
                ),
              ),

              subtitle: Padding(

                padding:
                const EdgeInsets.only(
                  top: 8,
                ),

                child:
                Text(recipe.description),
              ),
            ),
          );
        },
      ),
    );
  }
}