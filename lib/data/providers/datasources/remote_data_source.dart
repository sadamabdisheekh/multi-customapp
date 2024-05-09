import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'network_parser.dart';

abstract class RemoteDataSource {
  Future<dynamic> httpGet({required String url});
  Future<dynamic> httpPost(
      {required Map<String, dynamic> body, required String url});
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  Future<String> getToken() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? jsonString = prefs.getString(AppConstants.cachedUserResponseKey);
    // String token = '';

    // if (jsonString != null && jsonString.isEmpty) {
    //   Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //   token = VerifyOtp.fromMap(jsonMap).accessToken;
    // }
    // if (kDebugMode) {
    //   print('token $token');
    // }
    return 'appToken';
  }

  @override
  Future<dynamic> httpGet({required String url}) async {
    String token = await getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final uri = Uri.parse(url);

    if (kDebugMode) {
      print(uri);
    }

    final clientMethod =
        http.get(uri, headers: headers).timeout(const Duration(seconds: 59));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<dynamic> httpPost(
      {required Map<String, dynamic> body, required String url}) async {
    String token = await getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    if (kDebugMode) {
      print(url);
      print(json.encode(body));
    }
    final clientMethod =
        client.post(Uri.parse(url), headers: headers, body: json.encode(body));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
