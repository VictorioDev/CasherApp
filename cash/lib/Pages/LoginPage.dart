import 'dart:convert';

import 'package:cash/Components/CustomInputText.dart';
import 'package:cash/DAO/UserDAO.dart';
import 'package:cash/Models/User.dart';
import 'package:cash/Pages/SummaryPage.dart';
import 'package:cash/Utils/TextUtils.dart';
import 'package:flutter/material.dart';
import 'package:cash/Utils/MyColors.dart';

import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final emailField = new CustomInputText.withInputType(
      "Insert your email...", "Email", TextInputType.emailAddress);
  final passwordField = new CustomInputText.withCounterAndObscure(
      "Insert your password...", "Password", "Forgot your password?");

  void doLogin(BuildContext context) async {
    /*var user = User(
        email: emailField.getText(),
        password: Textutils.textToMd5(passwordField.getText()));
    setState(() {
      loading = true;
    });*/
    var user = User(
        email: "victorio@gmail.com", password: Textutils.textToMd5("123456"));
    setState(() {
      loading = true;
    });
    UserDAO.login(user).then((value) {
      print(value.body);
      Map<String, dynamic> response = jsonDecode(value.body);
      setState(() {
        loading = false;
      });
      if (value.statusCode == 200 && !response.containsKey("error")) {
        var loggedUser = User(id: response["user_id"], name: response["name"]);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SummaryPage(loggedUser)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                    "Welcome,",
                    style: TextStyle(
                      color: MyColors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign in to continue!",
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
                            onTap: () => doLogin(context),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [MyColors.red, MyColors.orange]),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: loading
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                MyColors.white),
                                      )
                                    : Text(
                                        "Login",
                                        style: TextStyle(
                                            color: MyColors.white,
                                            fontSize: 18),
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
                                  "I'm a new user. ",
                                  style: TextStyle(
                                      color: MyColors.black, fontSize: 18),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterPage()),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up!",
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
      ),
    );
  }
}
