import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:multi/data/models/customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_constants.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(AppConstants.cachedUserResponseKey);
    String token = '';
    if (jsonString != null && jsonString.isNotEmpty) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      token = CustomerModel.fromMap(jsonMap).token;
    }
    if (kDebugMode) {
      print('token $token');
    }
    return token;
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

    final clientMethod = http.get(uri, headers: headers);
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
