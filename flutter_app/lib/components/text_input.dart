import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String textString;
  final Function(String)? onSelectParam;
  final TextEditingController textController = TextEditingController();

  TextInput({Key? key, required this.textString, this.onSelectParam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFF000000)),
      cursorColor: const Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: textString,
        hintStyle: const TextStyle(
          color: Color(0xFF9b9b9b),
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
      onChanged: onSelectParam,
    );
  }
}
