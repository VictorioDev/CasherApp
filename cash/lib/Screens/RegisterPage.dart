import 'dart:async';
import 'package:cash/Components/CustomInputText.dart';
import 'package:cash/DAO/UserDAO.dart';
import 'package:cash/Models/User.dart';

import 'package:cash/Utils/TextUtils.dart';
import 'package:flutter/material.dart';
import 'package:cash/Utils/MyColors.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Timer timer;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  final emailField = new CustomInputText.withInputType(
      "Insert your email...", "Email", TextInputType.emailAddress);
  final passwordField =
      new CustomInputText.withObscure("Insert your password...", "Password");

  final nameField = new CustomInputText("Insert your name...", "Full name");

  doRegister(BuildContext context) {
    var user = User(
        name: nameField.getText(),
        email: emailField.getText(),
        password: Textutils.textToMd5(passwordField.getText()));
    print("Fields: " + user.toMapRegister().toString());
    UserDAO.register(user).then((response) {
      print("Body: " + response.body);
      if (response.statusCode == 201) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "Usuário criado com sucesso!",
            style:
                TextStyle(color: MyColors.white, fontWeight: FontWeight.bold),
          ),
        ));
        timer = new Timer(const Duration(milliseconds: 1000), () {
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Create Account",
                      style: TextStyle(
                        color: MyColors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign up to get started!",
                      style: TextStyle(
                        color: MyColors.gray,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: <Widget>[
                      nameField,
                      SizedBox(height: 10),
                      emailField,
                      SizedBox(height: 10),
                      passwordField,
                      SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () => doRegister(context),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [MyColors.red, MyColors.orange]),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: MyColors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "I'm already a user. ",
                                    style: TextStyle(
                                        color: MyColors.black, fontSize: 18),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Log In!",
                                      style: TextStyle(
                                          color: MyColors.orange, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
