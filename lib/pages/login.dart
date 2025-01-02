import 'dart:ui';
import 'package:cosmic/api/api_service.dart';
import 'package:cosmic/pages/profile.dart';
import 'package:cosmic/pages/signup.dart';
import 'package:cosmic/styling/custom_container.dart';
import 'package:cosmic/widgets/CustomButton.dart';
import 'package:cosmic/widgets/MyCustomTextFeild.dart';
import 'package:cosmic/widgets/bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showSnackBar('Please enter email and password');
      return;
    }

    final emailValid = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailValid.hasMatch(email)) {
      showSnackBar('Please enter a valid email');
      return;
    }

    setState(() {
      isLoading = true;
    });

    final apiService = ApiService();
    var newPostData = {
      'request': 'login',
      'email': email,
      'password': password,
    };

    var response = await apiService.postRequest("api/api.php", newPostData);
    setState(() {
      isLoading = false;
      emailController.clear();
      passwordController.clear();
    });

    if (response != null && response['status'] == 'success') {
      showSnackBar('Login successful!');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(email: email),
          ));
    } else {
      String errorMessage = response?['message'] ?? 'Login failed';
      showSnackBar(errorMessage);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
                color: const Color.fromARGB(255, 9,21,34).withOpacity(0.35),
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
                  LoginForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    onSignIn: signIn,
                    isLoading: isLoading,
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

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onSignIn;
  final bool isLoading;

  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onSignIn,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomStyledContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              MyCustomTextField(
                controller: emailController,
                hintText: 'email',
                obscureText: false,
              ),
              SizedBox(height: 15),
              MyCustomTextField(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {}, // Implement forgot password logic
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(0xFF11DCE8), fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              isLoading 
                  ? CircularProgressIndicator()
                  : Custombutton(
                      text: 'Sign in',
                      function: () => onSignIn(),
                    ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or sign in using", style: TextStyle(color: Colors.white54)),
                  ),
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                ],
              ),
              SizedBox(height: 15),
              SocialMediaIcons(),
              SizedBox(height: 20),
              SignUpLink(),
            ],
          ),
        ),
      ],
    );
  }
}

class SocialMediaIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: SvgPicture.asset("assets/icons/twitter.svg")),
        IconButton(onPressed: () {}, icon: SvgPicture.asset("assets/icons/facebook.svg")),
        IconButton(onPressed: () {}, icon: SvgPicture.asset("assets/icons/google.svg")),
      ],
    );
  }
}

class SignUpLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Signup()));
      },
      child: Text.rich(
        TextSpan(
          text: "Don’t have an account? ",
          style: TextStyle(color: Colors.white54),
          children: [
            TextSpan(
              text: "Sign Up",
              style: TextStyle(color: Color(0xFF11DCE8), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
