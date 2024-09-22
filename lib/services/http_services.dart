import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as tr;
import 'package:http/http.dart' as http;
import 'package:worthy_you/extensions/string_extentions.dart';

class HttpServices {
  static var internetMsg = {
    'success': false,
    'message': 'No internet connection!'.tr
  };

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<http.Response> postJson({
    String? token,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    required String url,
    bool userAgentRequired = false,
    bool isSignIn = false,
  }) async {
    if (!(await hasNetwork())) {
      return http.Response(json.encode(internetMsg), 400);
    }

    Map<String, String> headers;
    headers =  {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    if (queryParams != null) {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      url = uri.toString();
    }

    var request = http.Request("POST", Uri.parse(url));
    if (body != null) {
      request.body = jsonEncode(body);
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      "response Header:${response.headers}".printSuccess();
    }
    return await http.Response.fromStream(response);
  }

  static Future<http.StreamedResponse> postStreamJson({
    String? token,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    required String url,
    bool userAgentRequired = false,
    bool isSignIn = false,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accept': 'text/event-stream',
      'Authorization': '37d3d6868f6b4f89aff34e6e32cb6bc3',
      'X-USER-ID': 'pGjYUlPmDIS1kpUuY0OkviBXh8z1',
    };

    if (queryParams != null) {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      url = uri.toString();
    }

    var request = http.Request("POST", Uri.parse(url));

    if (body != null) {
      request.body = jsonEncode(body);
    }

    request.headers.addAll(headers);

    // Sending the request and getting the streamed response
    http.StreamedResponse response = await request.send();

    return response;
    // Listen to the byte stream
    await for (var chunk in response.stream.transform(utf8.decoder)) {
      // Process each chunk as an event stream
      if (kDebugMode) {
        print("Received event: $chunk");
      }

      // processEventStream(chunk);
    }

    if (kDebugMode) {
      print("Response headers: ${response.headers}");
    }
  }



  static Future<http.Response> postMultiPartJson({
    Map<String, String>? body,
    Map<String, dynamic>? files,
    required String url,
  }) async {
    if (!(await hasNetwork())) {
      return http.Response(json.encode(internetMsg), 400);
    }

    Map<String, String> headers;
    headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer 37d3d6868f6b4f89aff34e6e32cb6bc3',
      'X-USER-ID': 'pGjYUlPmDIS1kpUuY0OkviBXh8z1',
    };

    var request = http.MultipartRequest("POST", Uri.parse(url));
    if (body != null) {
      request.fields.addAll(body);
    }
    if (files != null) {
      files.forEach((key, value) async {
        request.files.add(await http.MultipartFile.fromPath(key, value));
      });
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return await http.Response.fromStream(response);
  }

}