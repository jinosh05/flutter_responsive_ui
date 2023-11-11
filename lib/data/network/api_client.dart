import "dart:async";
import "dart:convert";
import "dart:developer";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

import "../exception/app_exception.dart";
import "constant/endpoints.dart";

///
/// An API response handling class for handling the
/// [get],[post] methods and [Exception] handling
/// and also return the [http.Response.data]
///
class ApiClient {
  ///
  /// Get:---------------------------------------------------------------------
  ///
  Future<dynamic> get(
    String uri, {
    Map<String, String>? headers,
  }) async {
    final header = <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json",
    };
    if (headers != null) {
      header.addAll(headers);
    }
    try {
      final response = await http.get(Uri.parse(uri), headers: header).timeout(
        const Duration(milliseconds: Endpoints.connectionTimeout),
        onTimeout: () {
          throw TimeoutException("Connection Timeout");
        },
      );

      log(response.body);
      return _returnResponse(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  ///
  /// Post:--------------------------------------------------------------------
  ///
  Future<dynamic> post(
    String uri, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    final header = <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json",
    };
    if (headers != null) {
      header.addAll(headers);
    }
    try {
      debugPrint("URL : $uri");
      debugPrint("Working $data using header $header");
      final response = await http
          .post(
        Uri.parse(uri),
        headers: header,
        body: jsonEncode(data),
      )
          .timeout(
        const Duration(milliseconds: Endpoints.connectionTimeout),
        onTimeout: () {
          throw TimeoutException("Connection Timeout");
        },
      );

      log(response.body);

      return _returnResponse(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  ///
  /// Delete:------------------------------------------------------------------
  ///
  Future<dynamic> delete(
    String uri, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    final header = <String, String>{
      "accept": "application/json",
    };
    if (headers != null) {
      header.addAll(headers);
    }
    try {
      debugPrint("Working $data using header $header");

      final response = await http
          .delete(Uri.parse(uri), headers: header, body: data)
          .timeout(
        const Duration(milliseconds: Endpoints.connectionTimeout),
        onTimeout: () {
          throw TimeoutException("Connection Timeout");
        },
      );

      log(response.body);

      return _returnResponse(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = response.body;
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
          """
Error occured while Communication with Server with StatusCode : ${response.statusCode}""",
        );
    }
  }
}
