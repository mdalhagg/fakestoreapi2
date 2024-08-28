import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:fakestoreapi/apis.dart';
import 'package:http/http.dart' as http;
import 'package:fakestoreapi/models/http_response.dart';

class HTTPService {
  static Map<String, String> baseHeaders = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  static Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    Map<String, String> requestHeaders = {};
    requestHeaders.addAll(baseHeaders);
    requestHeaders.addAll(headers ?? {});

    http.Response? response;
    try {
      response = await http.get(
        Uri.parse("${API.baseUrl}$endpoint"),
        headers: requestHeaders,
      );
      response.body;
      AppHttpResponse localCacheResponse = AppHttpResponse(
          body: jsonDecode(response.body),
          statusCode: response.statusCode,
          message: response.reasonPhrase);

      await cacheResponse(response: localCacheResponse, url: endpoint)
          .then((value) {
        log('Cache Save Successfully');
      });
    } catch (e) {
      // log("$e");

      return _handleResponse(
        http.Response(
          '{}',
          500,
          reasonPhrase: 'Operation timed out',
        ),
      );
    }
    return _handleResponse(response);
  }

  static Future<dynamic> post(
    String endpoint, {
    required String body,
    Map<String, String>? headers,
  }) async {
    Map<String, String> requestHeaders = {};
    requestHeaders.addAll(baseHeaders);
    requestHeaders.addAll(headers ?? {});
    http.Response? response;
    try {
      response = await http.post(
        Uri.parse("${API.baseUrl}$endpoint"),
        headers: requestHeaders,
        body: body,
      );
    } catch (e) {
      return _handleResponse(
        http.Response(
          '',
          500,
          reasonPhrase: 'Operation timed out',
        ),
      );
    }
    return _handleResponse(response);
  }

  // Multipart POST request
  static Future<dynamic> multipartPost(
    String endpoint, {
    required Map<String, String> headers,
    required Map<String, String> data,
    required List<http.MultipartFile> files,
  }) async {
    Map<String, String> requestHeaders = {};
    requestHeaders.addAll(baseHeaders);
    requestHeaders.addAll(headers);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${API.baseUrl}$endpoint"),
    );
    request.headers.addAll(requestHeaders);
    request.fields.addAll(data);
    request.files.addAll(files);
    final response = await request.send();
    String responseString = await response.stream.bytesToString();
    // log(jsonEncode(data), name: "HTTPService");

    return _handleResponse(http.Response(
      responseString,
      response.statusCode,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
    ));
  }

  // DELETE request
  static Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    Map<String, String> requestHeaders = {};
    requestHeaders.addAll(baseHeaders);
    requestHeaders.addAll(headers ?? {});
    http.Response? response;
    try {
      response = await http.delete(
        Uri.parse("${API.baseUrl}$endpoint"),
        headers: requestHeaders,
      );
    } catch (e) {
      return _handleResponse(
        http.Response(
          '',
          500,
          reasonPhrase: 'Operation timed out',
        ),
      );
    }
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    // log(response.body, name: "HTTPService");
    try {
      final statusCode = response.statusCode;
      final responseBody = json.decode(response.body);

      if (statusCode >= 200 && statusCode < 300) {
        // log("$responseBody", name: "HTTPService");
        return responseBody;
      }
    } on FormatException {
      throw "تاكد من اتصالك بالانترنت";
    }
  }

  static Future<AppHttpResponse> cacheResponse({
    required String url,
    required AppHttpResponse response,
  }) async {
    Box httpCache = Hive.box('http_cache');
    await httpCache.put(url, jsonEncode(response.body));
    return response;
  }

  static Future<dynamic> getCachedResponse({required String url}) async {
    Box httpCache = Hive.box('http_cache');
    var data = await httpCache.get(url);
    if (data != null) {
      try {
        return jsonDecode(data);
      } catch (e) {
        await httpCache.delete(url);
        return null;
      }
    }
    return null;
  }
}
