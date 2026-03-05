
import 'dart:convert';

import 'package:chopper/chopper.dart';

class ApiCatchException {
   final Response response;

  ApiCatchException(this.response);

  String catchException() {

    if (response.bodyString.startsWith("{")) {
      // user utf8.decode to decode the response body bytes for khmer language
      Map error = json.decode(utf8.decode(response.bodyBytes));
      if (error.containsKey("errors")) {
        return error['Message'];
      } else {
        return error['Message'];
      }
    } else {
      return response.bodyString;
    }
  }
}