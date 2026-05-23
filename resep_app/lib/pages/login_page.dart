import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isLoading = false;

  String message = '';

  void login() async {

    setState(() {
      isLoading = true;
    });

    bool success =
    await AuthService.login(

      emailController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) =>
          const HomePage(),
        ),
      );

    } else {

      setState(() {
        message =
        'Email atau password salah';
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      Colors.deepPurple,

      body: Center(

        child: SingleChildScrollView(

          child: Padding(

            padding:
            const EdgeInsets.all(25),

            child: Container(

              padding:
              const EdgeInsets.all(25),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(25),
              ),

              child: Column(

                mainAxisSize:
                MainAxisSize.min,

                children: [

                  const Icon(

                    Icons.restaurant_menu,

                    size: 80,

                    color: Colors.deepPurple,
                  ),

                  const SizedBox(height: 20),

                  const Text(

                    'RESEP APP',

                    style: TextStyle(

                      fontSize: 28,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Login untuk melanjutkan',
                  ),

                  const SizedBox(height: 30),

                  TextField(

                    controller:
                    emailController,

                    decoration:
                    InputDecoration(

                      labelText: 'Email',

                      prefixIcon:
                      const Icon(Icons.email),

                      border:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(

                    controller:
                    passwordController,

                    obscureText: true,

                    decoration:
                    InputDecoration(

                      labelText:
                      'Password',

                      prefixIcon:
                      const Icon(Icons.lock),

                      border:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(

                    width: double.infinity,

                    height: 50,

                    child: isLoading

                        ? const Center(
                      child:
                      CircularProgressIndicator(),
                    )

                        : ElevatedButton(

                      style:
                      ElevatedButton.styleFrom(

                        backgroundColor:
                        Colors.deepPurple,

                        shape:
                        RoundedRectangleBorder(

                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: login,

                      child: const Text(

                        'LOGIN',

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(

                    message,

                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}