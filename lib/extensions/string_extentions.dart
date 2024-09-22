import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

extension NullableStringExtention on String? {
  String? removePlus() {
    if (this == null) return null;

    try {
      var data = this?.replaceFirst("+", "");
      return data;
    } catch (e) {
      if (kDebugMode) {
        print("Error parsing date: $e");
      }
    }
    return null;
  }

  String? maskString() {
    if (this == null) return null;
    if (this!.length <= 5) return this!;
    String masked =
        this!.substring(this!.length - 5).padLeft(this!.length, '*');
    return masked;
  }

  printSuccess() {
    if (kDebugMode) {
      log("\uD83C\uDF89 \uD83C\uDF89 \uD83C\uDF89 🙌 Response success Type: $this 🙌 \uD83C\uDF89 \uD83C\uDF89 \uD83C\uDF89");
    }
  }

  printFailure() {
    if (kDebugMode) {
      log("❌ ☠️ ☠️ Response Failed Type: $this ☠️ ☠️ ❌");
    }
  }

  Map? getParamsFromUrl() {
    if (this == null) return null;
    Uri uri = Uri.parse(this!);
    Map<String, String> queryParams = uri.queryParameters;
    return queryParams;
  }

  Map<String, dynamic>? toJson(){
    if (this == null) return null;
    try{
      return json.decode(this!);
    } catch(e){
      return null;
    }
  }
}
