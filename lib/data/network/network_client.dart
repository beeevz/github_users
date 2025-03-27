import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  Future<http.Response> get(String url) async {
    var response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return response;
  }
}
