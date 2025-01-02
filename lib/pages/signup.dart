// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'dart:ui';
import 'package:cosmic/api/api_service.dart';
import 'package:cosmic/pages/login.dart';
import 'package:cosmic/styling/custom_container.dart';
import 'package:cosmic/widgets/CustomButton.dart';
import 'package:cosmic/widgets/MyCustomTextFeild.dart';
import 'package:cosmic/widgets/bg.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void SignUp() async {
    final apiService = ApiService();
    var newPostData = {
      'request': 'register',
      'username': usernameController.text.trim().toString(),
      'email': emailController.text.trim().toString(),
      'password': passwordController.text.trim().toString(),
    };

    var response = await apiService.postRequest("api/api.php", newPostData);
    if (response != null && response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      String errorMessage = response?['message'] ?? 'Registration failed';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          const BG(),
          Center(
            child: Container(
              height: double.infinity,
              width: screenWidth * 0.75,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 9, 21, 34).withOpacity(0.35),
                borderRadius: BorderRadius.circular(10),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/img/logo.png"),
                  Column(
                    children: [
                      CustomStyledContainer(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            MyCustomTextField(
                              controller: usernameController,
                              hintText: 'username',
                              obscureText: false,
                            ),
                            const SizedBox(height: 15),
                            MyCustomTextField(
                              controller: emailController,
                              hintText: 'email',
                              obscureText: false,
                            ),
                            const SizedBox(height: 15),
                            MyCustomTextField(
                              controller: passwordController,
                              hintText: 'password',
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            Custombutton(
                              text: 'Sign up',
                              function: SignUp,
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
                              child: const Text.rich(
                                TextSpan(
                                  text: "Do you have an account? ",
                                  style: TextStyle(color: Colors.white54),
                                  children: [
                                    TextSpan(
                                      text: "Sign in",
                                      style: TextStyle(
                                          color: Color(0xFF11DCE8),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
