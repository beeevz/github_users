import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:github_users/common/globals.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  final globals = GetIt.instance<Globals>();

  Future<http.Response> get(String path) async {
    final uri = "${globals.domain}$path";
    var response = await http.get(
      Uri.parse(uri),
      headers: {"Authorization: Bearer": globals.apiKey},
    );
    if (kDebugMode) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return response;
  }
}
