import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/router_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../error/exception.dart';
import 'remote_data_source.dart';

class NetworkParser {
  static const _className = 'RemoteDataSourceImpl';

  static Future<dynamic> callClientWithCatchException(
      CallClientMethod callClientMethod) async {
    try {
      final response = await callClientMethod();
      log(response.statusCode.toString(), name: _className);
      log(response.body, name: _className);
      return _responseParser(response);
    } on SocketException {
      log('SocketException', name: _className);
      throw const NetworkException('No internet connection', 10061);
    } on FormatException {
      log('FormatException', name: _className);
      throw const DataFormateException('Data format exception', 422);
    } on http.ClientException {
      ///503 Service Unavailable
      log('http ClientException', name: _className);
      throw const NetworkException('Service unavailable', 503);
    } on TimeoutException {
      log('TimeoutException', name: _className);
      throw const NetworkException('Request timeout', 408);
    }
  }

  static _responseParser(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(response.body);
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(response.body);
        sessionExpired();
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 406:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 406);
      case 408:

        ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:

        /// 415 Unsupported Media Type
        throw const DataFormateException('Data formate exception');

      case 422:

        ///Unprocessable Entity
        final errorMsg = parsingError(response.body);
        throw InvalidInputException(errorMsg, 422);
      case 500:

        ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        throw FetchDataException(
            'Error occur while communication with Server', response.statusCode);
    }
  }

  static String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }

    return 'Unknown error';
  }

  static String parsingDoseNotExist(String body) {
    try {
      Map<String, dynamic> jsonMap = json.decode(body);
      if (jsonMap.containsKey('message')) {
        dynamic message = jsonMap['message'];
        if (message is List) {
          return message.first;
        } else {
          return message;
        }
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }
    return 'uknown error';
  }

  static Future<void> sessionExpired() async {
    // get the Get current
    final currentRoute = Get.currentRoute;
    if (currentRoute != RouteNames.signinScreen) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(AppConstants.cachedUserResponseKey);
      prefs.clear();
      Get.offAllNamed(RouteNames.signinScreen);
    }
  }
}
