import 'dart:convert';

import 'package:cash/DAO/MovimentationDAO.dart';
import 'package:cash/Models/User.dart';
import 'package:cash/Utils/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

class MovimentationsPage extends StatefulWidget {
  User user;
  MovimentationsPage({Key key, this.user}) : super(key: key);

  _MovimentationsPageState createState() => _MovimentationsPageState();
}

class _MovimentationsPageState extends State<MovimentationsPage> {
  var hits = [];
  var loading = false;
  void getMovimentations() {
    setState(() {
      loading = true;
    });
    MovimentationDAO.getMovimentations(widget.user).then((response) {
      if (response.statusCode == 200) {
        var mapResponse = Map<String, dynamic>();
        print(response.body);
        mapResponse = jsonDecode(response.body);
        var innerHints = mapResponse["hits"];

        setState(() {
          hits = innerHints;
        });
      }
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.user.balance);
    getMovimentations();
  }

  Widget buildContentHeader(var screenHeigth) {
    return Column(
      children: <Widget>[
        Container(
          color: widget.user.positiveBalance ? Colors.green : Colors.red,
          height: screenHeigth * 0.2,
          child: Center(
            child: widget.user.positiveBalance
                ? Text(
                    "+ ${widget.user.balance}",
                    style: TextStyle(
                        color: widget.user.positiveBalance
                            ? Colors.white
                            : Colors.black,
                        fontSize: 40),
                  )
                : Text(
                    "- ${widget.user.balance}",
                    style: TextStyle(
                        color: widget.user.positiveBalance
                            ? Colors.white
                            : Colors.black,
                        fontSize: 40),
                  ),
          ),
        ),
      ],
    );
  }

  Widget buildMainList(var context, var screenWidth) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: hits.length,
          itemBuilder: (context, index) =>
              buildListTile(index, screenWidth, context),
        ),
      ),
    );
  }

  Widget buildListTile(var index, var screenWidth, var context) {
    var mov = hits[index];
    var movDescription = mov["name"];
    //var movMap = jsonDecode(mov);
    print(mov);
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            "$movDescription",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        title: Hero(
          tag: "user-name",
          child: Material(
            color: Colors.transparent,
            child: Container(
                child: Text(
              "${widget.user.name}",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
          ),
        ),
        backgroundColor: MyColors.white,
      ),
      body: Column(
        children: <Widget>[
          buildContentHeader(screenHeigth),
          loading
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : buildMainList(context, screenWidth)
        ],
      ),
    );
  }
}
