import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/recipe_model.dart';
import '../services/auth_service.dart';

class EditRecipePage extends StatefulWidget {
  final Recipe recipe;

  const EditRecipePage({super.key, required this.recipe});

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    titleController.text = widget.recipe.title;

    descriptionController.text = widget.recipe.description;
  }

  Future<void> updateRecipe() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    String? token = await AuthService.getToken();

    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/api/recipes/${widget.recipe.id}'),

      headers: {
        'Accept': 'application/json',

        'Authorization': 'Bearer $token',

        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        'title': titleController.text,

        'description': descriptionController.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Resep berhasil diupdate')));

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.body)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Resep'),

        backgroundColor: Colors.deepPurple,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            children: [
              TextFormField(
                controller: titleController,

                decoration: const InputDecoration(labelText: 'Judul Resep'),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: descriptionController,

                maxLines: 4,

                decoration: const InputDecoration(labelText: 'Deskripsi'),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: isLoading ? null : updateRecipe,

                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('UPDATE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
