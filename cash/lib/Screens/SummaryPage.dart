import 'dart:convert';

import 'package:cash/DAO/UserDAO.dart';
import 'package:cash/Models/User.dart';
import 'package:cash/Utils/MyColors.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  final User user;

  SummaryPage(this.user);

  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  bool loaded = false;

  int balance = 0;
  bool positiveBalance = false;

  doRequest() {
    print("Do request");
    print(widget.user.id);
    UserDAO.summary(widget.user).then((data) {
      if (data.statusCode == 200) {
        Map<String, dynamic> toObject = jsonDecode(data.body);
        int innerBalance = toObject["balance"];
        bool innerPositiveBalance = toObject["positive_balance"];
        setState(() {
          balance = innerBalance;
          positiveBalance = innerPositiveBalance;
          loaded = true;
        });
      } else {
        print("Different status code");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init state");
    doRequest();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget progressIndicator() {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome back ${widget.user.name}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Balance:",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${balance}",
              style: TextStyle(
                  fontSize: 20,
                  color: positiveBalance ? Colors.grey : Colors.red),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [MyColors.red, MyColors.orange], stops: [0.1, 0.9]),
        ),
        child: Center(
          child: Container(
            width: width * 0.75,
            height: 200,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: loaded ? content() : progressIndicator()),
          ),
        ),
      ),
    );
  }
}
