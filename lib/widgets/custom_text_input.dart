import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    required this.controller,
    this.title = '',
    this.hint = '',
    this.inputType = TextInputType.text,
  }) : super(key: key);

  /// text editing controller
  final TextEditingController controller;
  final String title, hint;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: size.width * 0.9,
            height: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration.collapsed(hintText: this.hint),
              keyboardType: this.inputType,
            ),
          ),
        ],
      ),
    );
  }
}
