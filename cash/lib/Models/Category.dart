class Category {
  //categories(id, name)
  int _id;
  String _name;

  Category(this._id, this._name);

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
}
