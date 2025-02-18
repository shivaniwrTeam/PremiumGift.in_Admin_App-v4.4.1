import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'Constant.dart';
import 'Session.dart';

class ApiBaseHelper {
  Future<dynamic> postAPICall(Uri url, Map parameter) async {
    var responseJson;
    print("parameter : $parameter");
    try {
      final response = await post(url,
              body: parameter.isNotEmpty ? parameter : null, headers: headers,)
          .timeout(const Duration(seconds: timeOut));
      print(
          "Parameter = $parameter , API = $url,response : ${response.body}",);
      responseJson = _response(response);
      log("responjson** $url --> $parameter ----**$responseJson");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Something went wrong, try again later');
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    print("response statuscode*****${response.statusCode}");
    print("response -------**** ${response.body}-------${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}',);
    }
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;
  CustomException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
