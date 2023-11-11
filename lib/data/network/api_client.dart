import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_responsive_ui/data/exception/app_exception.dart';
import 'package:flutter_responsive_ui/data/network/constant/endpoints.dart';
import 'package:http/http.dart' as http;

///
/// An API response handling class for handling the
/// [get],[post] methods and [Exception] handling
/// and also return the [http.Response.data]
///
class ApiClient {
  ///
  /// Get:-----------------------------------------------------------------------
  ///
  Future<dynamic> get(
    String uri, {
    Map<String, String>? headers,
  }) async {
    try {
      final http.Response response =
          await http.get(Uri.parse(uri), headers: headers).timeout(
        const Duration(milliseconds: Endpoints.connectionTimeout),
        onTimeout: () {
          throw TimeoutException("Connection Timeout");
        },
      );
      return _returnResponse(response);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  ///
  /// Post:----------------------------------------------------------------------
  ///
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, String>? headers,
  }) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: data).timeout(
        const Duration(milliseconds: Endpoints.connectionTimeout),
        onTimeout: () {
          throw TimeoutException("Connection Timeout");
        },
      );
      return _returnResponse(response);
    } catch (e) {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        debugPrint(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorisedException(response.body);
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
        throw ServerNotFoundException(response.body);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
