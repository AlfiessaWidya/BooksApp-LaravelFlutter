import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final int fontSize;
  final bool isUnderLine;
  final Color color;

  TextWidget({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.isUnderLine = false,
    this.color = const Color(0xFF363f93),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 3, // space between underline and text
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isUnderLine ? const Color(0xFF363f93) : const Color(0xFFFFFFFF), // Text color here
            width: 1.0, // Underline width
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize.toDouble(),
          fontFamily: "Avenir",
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    );
  }
}
