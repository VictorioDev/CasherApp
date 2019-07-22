import 'package:cash/Models/ApiResponse.dart';
import 'package:cash/Models/User.dart';
import 'package:cash/Sevice/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserDAO {
  static Future<Response> login(User user) async {
    final String modelRoute = "/login";
    print("User:" + user.toMapLogin().toString());
    var response = await http.post(ApiConfig.BASE_URL + modelRoute,
        body: user.toMapLogin());

    return response;
  }

  static Future<Response> register(User user) async {
    final String modelRoute = "/users";
    var response = await http.post(ApiConfig.BASE_URL + modelRoute,
        body: user.toMapRegister());
    if (response.body.isEmpty) return null;
    return response;
  }

  static Future<Response> summary(User user) async {
    final String modelRoute = "/summary/${user.getId()}";
    print(ApiConfig.BASE_URL + modelRoute);
    var response = await http.get(
      ApiConfig.BASE_URL + modelRoute,
    );
    if (response.body.isEmpty) return null;
    return response;
  }
}
