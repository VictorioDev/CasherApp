import 'package:cash/Models/Movimentation.dart';

class Tag {
  //tags(id, name, move_id)
  int _id;
  String _name;
  Movimentation _movimentation;

  Tag(this._id, this._name, this._movimentation);

  int getId() {
    return this._id;
  }

  setId(int id) {
    this._id = id;
  }

  String getName() {
    return this._name;
  }

  setName(String name) {
    this._name = name;
  }

  Movimentation getMovimentation() {
    return this._movimentation;
  }

  setMovimentation(Movimentation movimentation) {
    this._movimentation = movimentation;
  }
}
