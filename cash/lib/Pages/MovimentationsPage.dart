import 'dart:convert';

import 'package:cash/DAO/MovimentationDAO.dart';
import 'package:cash/Models/Category.dart' as prefix0;
import 'package:cash/Models/Movimentation.dart';
import 'package:cash/Models/User.dart';
import 'package:cash/Utils/MyColors.dart';
import 'package:flutter/foundation.dart';
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
  var nameController = TextEditingController();
  var valueController = TextEditingController();
  void getMovimentations() {
    setState(() {
      loading = true;
    });
    MovimentationDAO.getMovimentations(widget.user).then((response) {
      if (response.statusCode == 200) {
        var mapResponse = Map<String, dynamic>();

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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              var checkBox = true;

              // return object of type Dialog
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: new Text("New Movimentation"),
                    content: Container(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextField(
                                autofocus: true,
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: "Enter name...",
                                    labelText: "Movimentation name",
                                    counterStyle:
                                        TextStyle(color: MyColors.black)),
                              ),
                              TextField(
                                controller: valueController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                    hintText: "Enter value...",
                                    labelText: "Movimentation value",
                                    counterStyle:
                                        TextStyle(color: MyColors.black)),
                              ),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: checkBox,
                                    onChanged: (bool value) {
                                      //print("value: " + value.toString());
                                      //print("Check:" + checkBox.toString());
                                      setState(() {
                                        checkBox = value;
                                      });
                                    },
                                  ),
                                  Text("Use current date")
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Add"),
                        onPressed: () {
                          var movimentation = Movimentation(
                              categorie: prefix0.Category(1, "Foda-se"),
                              date: DateTime.now(),
                              value: double.parse(valueController.text),
                              name: nameController.text,
                              type: "C",
                              user: widget.user);
                          MovimentationDAO.newMov(movimentation).then((value) {
                            print(value.body);
                          });
                          Navigator.of(context).pop();
                          getMovimentations();
                        },
                      ),
                      new FlatButton(
                        child: new Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
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
