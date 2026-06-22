import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
  final ingredientsController = TextEditingController();
  final toolsController = TextEditingController();
  final stepsController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  File? image;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.recipe.title;
    descriptionController.text = widget.recipe.description;
    ingredientsController.text = widget.recipe.ingredients;
    toolsController.text = widget.recipe.tools;
    stepsController.text = widget.recipe.steps;
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> updateRecipe() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    String? token = await AuthService.getToken();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8000/api/recipes/${widget.recipe.id}'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    request.fields['_method'] = 'PUT';

    request.fields['title'] = titleController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['ingredients'] = ingredientsController.text;
    request.fields['tools'] = toolsController.text;
    request.fields['steps'] = stepsController.text;

    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', image!.path),
      );
    }

    var response = await request.send();

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
      ).showSnackBar(const SnackBar(content: Text('Gagal update resep')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F0FF),

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,

        title: const Text("Edit Resep", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Form(
            key: formKey,

            child: Card(
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Center(
                      child: Text(
                        "✏ Edit Resep",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      controller: titleController,

                      decoration: InputDecoration(
                        labelText: "Judul Resep",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Judul wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: descriptionController,

                      maxLines: 4,

                      decoration: InputDecoration(
                        labelText: "Deskripsi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: ingredientsController,

                      maxLines: 5,

                      decoration: InputDecoration(
                        labelText: "🥬 Bahan-bahan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: toolsController,

                      maxLines: 4,

                      decoration: InputDecoration(
                        labelText: "🔪 Alat",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: stepsController,

                      maxLines: 8,

                      decoration: InputDecoration(
                        labelText: "👨‍🍳 Langkah-langkah",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),

                            child: Image.file(
                              image!,
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),

                            child: Image.network(
                              "http://10.0.2.2:8000/storage/${widget.recipe.image}",
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,

                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 220,
                                  color: Colors.grey.shade200,

                                  child: const Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 80,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),

                        onPressed: pickImage,

                        icon: const Icon(Icons.photo, color: Colors.white),

                        label: const Text(
                          "Pilih Gambar Baru",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),

                        onPressed: isLoading ? null : updateRecipe,

                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "✏ UPDATE RESEP",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
