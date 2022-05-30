import 'package:buy_kiosko/clients/base_client.dart';
import 'package:buy_kiosko/utils/end_points.dart' as EndPoints;
import 'package:buy_kiosko/utils/globals.dart' as globals;
import 'dart:convert';

class TransactionClient extends BaseClient {
  Future<Map> payment(String stringData) async {
    Map data = json.decode(stringData);
    Map mapData = {
      'amount': data['amount'],
      'description': data['description'],
      'senderAccountId': globals.currentUser['accountId'],
      'receiverAccountId': data['receiverAccountId'],
    };
    return this.post(EndPoints.PAYMENT, mapData);
  }
}
