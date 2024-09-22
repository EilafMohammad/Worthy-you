import 'package:http/http.dart' as http;
import 'package:worthy_you/extensions/string_extentions.dart';

extension ResponseExtention on http.Response {
  Future<bool> isSuccessful() async {
    if (statusCode >= 200 && statusCode <= 300) {
      body.printSuccess();

      return true;
    } else {
      body.printFailure();
      return false;
    }
  }
}
