import 'package:cash/Models/Category.dart';
import 'package:cash/Models/User.dart';

class Movimentation {
  //movimentation(id, type [C, D], value, date, category_id)
  int id;
  String type;
  double value;
  DateTime date;
  Category categorie;
  String name;
  User user;

  Movimentation(
      {this.id,
      this.type,
      this.name,
      this.value,
      this.date,
      this.categorie,
      this.user});

  int getId() {
    return this.id;
  }

  setId(int id) {
    this.id = id;
  }

  String getType() {
    return this.type;
  }

  setType(String type) {
    this.type = type;
  }

  double getValue() {
    return this.getValue();
  }

  setValue(double value) {
    this.value = value;
  }

  DateTime getDate() {
    return this.getDate();
  }

  setDate(DateTime dateTime) {
    this.date = dateTime;
  }

  Category getCategorie(Category categorie) {
    return this.categorie;
  }

  setCategoria(Category categorie) {
    this.categorie = categorie;
  }

  User getUser() {
    this.user;
  }

  setUser(User user) {
    this.user = user;
  }

  Map toMapNew() {
    var map = Map<String, dynamic>();
    /*
      "user_id": 1,
	"type": "D",
	"name": "Foo bar",
	"value": 99.21,
	"date": "2019-08-20 21:23:12",
	"category_id": 1
     */
    map['name'] = this.name;
    map['value'] = this.value.toString();
    map['category_id'] = this.categorie.getId().toString();
    map['type'] = this.type;
    map['user_id'] = this.user.id.toString();

    return map;
  }
}
