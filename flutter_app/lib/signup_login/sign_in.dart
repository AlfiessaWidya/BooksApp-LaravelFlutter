import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/my_api.dart';
import 'package:flutter_app/components/text_widget.dart';
import 'package:flutter_app/pages/article_page.dart';
import 'package:flutter_app/signup_login/sign_up.dart';
import 'package:flutter_app/welcome/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _showMsg(String msg) {
    final snackBar = SnackBar(
      padding: EdgeInsets.all(9),
      backgroundColor: const Color(0xFF363f93),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _login() async {
    var data = {
      'email': emailController.text,
      'password': textController.text,
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    if (body['success'] ?? false) { // Check if 'success' is null and default to false
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ArticlePage()),
      );
    } else {
      _showMsg(body['message'] ?? 'An error occurred'); // Handle the case where 'message' might be null
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.1),
              Container(
                padding: const EdgeInsets.only(left: 0, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.only(right: 20),
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF363f93)),
                      onPressed: () => (
                        // tatr
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()))
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.1),
              TextWidget(text: "Welcome Back!", fontSize: 26, isUnderLine: false),
              SizedBox(height: height * 0.1),
              TextInput(
                textString: "Email",
                textController: emailController,
                hint: "Email",
              ),
              SizedBox(height: height * 0.05),
              TextInput(
                textString: "Password",
                textController: textController,
                hint: "Password",
                obscureText: true,
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: "Sign in", fontSize: 22, isUnderLine: false,),
                  GestureDetector(
                    onTap: _login,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF363f93),
                      ),
                      child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: TextWidget(text: "Sign up", fontSize: 16, isUnderLine: true),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: TextWidget(text: "Forgot Password", fontSize: 16, isUnderLine: true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final String textString;
  final TextEditingController textController;
  final String hint;
  final bool obscureText;

  const TextInput({
    Key? key,
    required this.textString,
    required this.textController,
    required this.hint,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFF000000)),
      cursorColor: const Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: textString,
        hintStyle: const TextStyle(
          color: Color(0xFF9b9b9b),
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
