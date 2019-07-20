class User {
  //users(id, email, password)

  int _id;
  String _email;
  String _password;

  User(this._id, this._email, this._password);

  int getId() {
    return this._id;
  }

  setId(int id) {
    this._id = id;
  }

  String getEmail() {
    return this._email;
  }

  setEmail(String email) {
    this._email = email;
  }

  String getPassword() {
    return this._password;
  }

  setPassword(String password) {
    this._password = password;
  }
}
