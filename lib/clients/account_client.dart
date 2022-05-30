import 'package:buy_kiosko/clients/base_client.dart';
import 'package:buy_kiosko/utils/end_points.dart' as EndPoints;
import 'package:buy_kiosko/utils/globals.dart' as globals;

class AccountClient extends BaseClient {
  Future<Map> findByCurrentUser() async {
    String url = '${EndPoints.ACCOUNT_BY_USER_ID}${globals.currentUser['id']}';
    return this.get(url);
  }
}
