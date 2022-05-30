import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseClient {
  Future<Map> post(String url, data) async {
    var client = http.Client();
    try {
      var uri = Uri.parse(url);
      String body = json.encode(data);
      print('... Start post request ...');
      var response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: body,
          encoding: Encoding.getByName("utf-8"));
      print('... End post request...');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.bodyBytes.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      print('Error to request post...');
      print(e.toString());
      return {'error': 'Ha ocurrido un error al solicitar el servicio.'};
    } finally {
      client.close();
    }
  }

  Future<Map> get(String url) async {
    var client = http.Client();
    try {
      var uri = Uri.parse(url);
      print('... Start get request ...');
      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      });
      print('... End post request...');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.bodyBytes.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      print('Error to request post...');
      print(e.toString());
      return {'error': 'Ha ocurrido un error al solicitar el servicio.'};
    } finally {
      client.close();
    }
  }
}
