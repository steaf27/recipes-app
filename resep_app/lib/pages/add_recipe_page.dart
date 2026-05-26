import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/auth_service.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> saveRecipe() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    String? token = await AuthService.getToken();

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/recipes'),

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

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Resep berhasil ditambah')));

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
        title: const Text('Tambah Resep'),

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
                  onPressed: isLoading ? null : saveRecipe,

                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('SIMPAN'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
