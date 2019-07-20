import 'package:cash/Utils/MyColors.dart';
import 'package:flutter/material.dart';

class CustomInputText extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  String labelText;
  String counterText = "";

  CustomInputText.withCounter(
      this.controller, this.hintText, this.labelText, this.counterText);

  CustomInputText(this.controller, this.hintText, this.labelText);

  _CustomInputTextState createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          counterText: widget.counterText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: MyColors.gray),
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
          counterStyle: TextStyle(color: MyColors.black)),
    );
  }
}

Widget _customTextField(TextEditingController controller, String hintText,
    String labelText, bool needCounterText, String counterText) {}
