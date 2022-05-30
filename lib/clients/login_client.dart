import 'package:buy_kiosko/clients/base_client.dart';
import 'package:buy_kiosko/utils/end_points.dart' as EndPoints;

class LoginClient extends BaseClient {
  Future<Map> login(String username, String password) async {
    Map data = {'username': username, 'password': password};
    return this.post(EndPoints.LOGIN, data);
  }
}
