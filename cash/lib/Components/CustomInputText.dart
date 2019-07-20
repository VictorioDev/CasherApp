import 'package:cash/Utils/MyColors.dart';
import 'package:flutter/material.dart';

class CustomInputText extends StatefulWidget {
  String hintText;
  String labelText;
  String counterText = "";
  bool obscure = false;
  TextInputType inputType;

  var controller = TextEditingController();

  String getText() {
    return this.controller.text;
  }

  CustomInputText.withCounter(this.hintText, this.labelText, this.counterText);

  CustomInputText.withCounterAndObscure(
      this.hintText, this.labelText, this.counterText) {
    this.obscure = true;
  }

  CustomInputText.withObscure(this.hintText, this.labelText) {
    this.obscure = true;
  }

  CustomInputText(this.hintText, this.labelText);

  CustomInputText.withInputType(this.hintText, this.labelText, this.inputType);

  _CustomInputTextState createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscure,
      keyboardType: widget.inputType,
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
