import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/my_api.dart';
import 'package:flutter_app/components/text_widget.dart';
import 'package:flutter_app/pages/article_page.dart';
import 'package:flutter_app/signup_login/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController repassController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _register() async {
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passController.text,
    };
    debugPrint(nameController.text);
    debugPrint(emailController.text);
    debugPrint(passController.text);
    debugPrint(repassController.text);

    var res = await CallApi().postData(data, 'register');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ArticlePage()),
      );
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
                margin: const EdgeInsets.only(left: 0, right: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: IconButton(
                        padding: EdgeInsets.only(right: 20),
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF363f93)),
                        onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),
                      ),
                    ),
                    TextWidget(
                      text: "Create account",
                      fontSize: 26,
                      isUnderLine: false
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 20),
              
              SizedBox(height: 20),
              TextInput(
                textString: "Name",
                textController: nameController,
                hint: "Name",
              ),
              SizedBox(height: height * 0.05),
              TextInput(
                textString: "Email",
                textController: emailController,
                hint: "Email",
              ),
              SizedBox(height: height * 0.05),
              TextInput(
                textString: "Password",
                textController: passController,
                hint: "Password",
                obscureText: true,
              ),
              SizedBox(height: height * 0.05),
              TextInput(
                textString: "Confirm Password",
                textController: repassController,
                hint: "Confirm Password",
                obscureText: true,
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: "Sign Up", fontSize: 22, isUnderLine: false),
                  GestureDetector(
                    onTap: _register,
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
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    child: TextWidget(text: "Sign In", fontSize: 16, isUnderLine: true),
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
  final bool obscureText;
  final String hint;

  const TextInput({
    Key? key,
    required this.textString,
    required this.textController,
    this.obscureText = false,
    required this.hint,
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
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF9b9b9b),
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
