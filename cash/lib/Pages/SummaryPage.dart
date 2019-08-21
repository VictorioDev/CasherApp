import 'dart:convert';

import 'package:cash/DAO/UserDAO.dart';
import 'package:cash/Models/User.dart';
import 'package:cash/Pages/MovimentationsPage.dart';
import 'package:cash/Utils/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/rendering.dart';

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
    UserDAO.summary(widget.user).then((data) {
      if (data.statusCode == 200) {
        Map<String, dynamic> toObject = jsonDecode(data.body);
        int innerBalance = toObject["balance"];
        bool innerPositiveBalance = toObject["positive_balance"];
        widget.user.balance = innerBalance;
        widget.user.positiveBalance = innerPositiveBalance;
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
            Hero(
              tag: "user-name",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  child: Text(
                    "${widget.user.name}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
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
      body: Stack(
        children: <Widget>[
          Container(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(10),
              width: 180,
              height: 50,
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.black, width: 0.5),
              ),
              margin: EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    prefix0.MaterialPageRoute(
                      builder: (context) => MovimentationsPage(
                            user: widget.user,
                          ),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "Gerenciar",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
