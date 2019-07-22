class User {
  //users(id, email, password)

  int id;
  String name;
  String email;
  String password;

  User({this.id, this.name, this.email, this.password});

  int getId() {
    return this.id;
  }

  setId(int id) {
    this.id = id;
  }

  String getName() {
    return this.name;
  }

  setName(String name) {
    this.name = name;
  }

  String getEmail() {
    return this.email;
  }

  setEmail(String email) {
    this.email = email;
  }

  String getPassword() {
    return this.password;
  }

  setPassword(String password) {
    this.password = password;
  }

  Map toMapLogin() {
    var map = Map<String, dynamic>();
    map["email"] = this.email;
    map["password"] = this.password;
    return map;
  }

  Map toMapRegister() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    map["email"] = this.email;
    map["password"] = this.password;
    return map;
  }
}
