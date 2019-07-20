import 'package:cash/Models/Categorie.dart';
import 'package:cash/Models/User.dart';

class Movimentation {
  //movimentation(id, type [C, D], value, date, category_id)
  int _id;
  String _type;
  double _value;
  DateTime _date;
  Categorie _categorie;
  User _user;

  Movimentation(this._id, this._type, this._value, this._date, this._categorie,
      this._user);

  int getId() {
    return this._id;
  }

  setId(int id) {
    this._id = id;
  }

  String getType() {
    return this._type;
  }

  setType(String type) {
    this._type = type;
  }

  double getValue() {
    return this.getValue();
  }

  setValue(double value) {
    this._value = value;
  }

  DateTime getDate() {
    return this.getDate();
  }

  setDate(DateTime dateTime) {
    this._date = dateTime;
  }

  Categorie getCategorie(Categorie categorie) {
    return this._categorie;
  }

  setCategoria(Categorie categorie) {
    this._categorie = categorie;
  }

  User getUser() {
    this._user;
  }

  setUser(User user) {
    this._user = user;
  }
}
