import 'package:cash/Models/Movimentation.dart';
import 'package:cash/Models/User.dart';
import 'package:cash/Sevice/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MovimentationDAO {
  static Future<Response> getMovimentations(User user) async {
    final String modelRoute = "/movimentations/";
    var response =
        await http.get(ApiConfig.BASE_URL + modelRoute + "${user.id}");
    if (response.body.isEmpty) {
      return null;
    }
    return response;
  }

  static Future<Response> newMov(Movimentation mov) async {
    final String modelRoute = "/movimentations";
    var response =
        await http.post(ApiConfig.BASE_URL + modelRoute, body: mov.toMapNew());
    if (response.body.isEmpty) {
      return null;
    }
    return response;
  }
}
