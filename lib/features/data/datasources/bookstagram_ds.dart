import 'dart:async';
import 'dart:convert';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/features/data/datasources/network_error.dart';
import 'package:bookstagram/features/data/models/change_pass_model.dart';
import 'package:bookstagram/features/data/models/forgot_email_model.dart';
import 'package:bookstagram/features/data/models/forgot_otp_model.dart';
import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/data/models/signup_model.dart';
import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class APIResult {
  final NetworkAPIStatus status;
  final dynamic data;

  APIResult(this.status, this.data);
}

class RemoteDs {
  RemoteDs();
  // ignore: non_constant_identifier_names
  final _BASE_URL = "https://api.bookstagram.online/";
  Future<dynamic> loginToBookstagram({
    required String email,
    required String pass,
    required String phoneNumber,
    required String language,
    required String authType,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      "email": email,
      "password": pass,
      "phoneNumber": phoneNumber,
      "language": language,
      "authType": authType
    });

    final response = await http.post(
      Uri.parse('$_BASE_URL${AppConfig.signIn}'),
      headers: headers,
      body: body,
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final obj = LoginModel.fromJson(jsonDecode(response.body));

      return obj;
    } else {
      // Map<String, dynamic> responseData = jsonDecode(response.body);
      // print("body ${responseData["reason"]}");
      final reason = handleError(response.body);
      if (reason.isEmpty) {
        throw Exception("unable to reach now.");
      }
      throw Exception(reason);
    }
  }

  Future<dynamic> signUpToBookstagram({
    required String email,
    required String countryCode,
    required String phoneNumber,
    required String fullname,
    required String firstname,
    required String lastname,
    required String pass,
    required String language,
    required String authType,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      "email": email,
      "countryCode": countryCode,
      "phoneNumber": phoneNumber,
      "fullName": {
        // "kaz":"kjbsdfdsbfs",
        "eng": fullname
        // "rus":"Avtarrus"
      },
      "firstName": {
        // "kaz":"kjbsdfdsbfs",
        "eng": firstname
        // "rus":"Avtarrus"
      },
      "lastName": {
        // "kaz":"kjbsdfdsbfs",
        "eng": lastname
        // "rus":"Avtarrus"
      },
      "password": pass,
      "language": language,
      "authType": authType,
    });

    final response = await http.post(
      Uri.parse('$_BASE_URL${AppConfig.signUp}'),
      headers: headers,
      body: body,
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final obj = SignUpModel.fromJson(jsonDecode(response.body));

      return obj;
    } else {
      final reason = handleError(response.body);
      if (reason.isEmpty) {
        throw Exception("unable to reach now.");
      }
      throw Exception(reason);
    }
  }

  Future<dynamic> verifySignupOtp({
    required String email,
    required String otpCode,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      "email": email,
      "otp": otpCode,
    });

    final response = await http.post(
      Uri.parse('$_BASE_URL${AppConfig.verifySignUp}'),
      headers: headers,
      body: body,
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final obj = VerificationOtpModel.fromJson(jsonDecode(response.body));

      return obj;
    } else {
      final reason = handleError(response.body);
      if (reason.isEmpty) {
        throw Exception("unable to reach now.");
      }
      throw Exception(reason);
    }
  }

  Future<dynamic> forgotEmail({
    required String email,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      "email": email,
    });

    final response = await http.post(
      Uri.parse('$_BASE_URL${AppConfig.forgotEmail}'),
      headers: headers,
      body: body,
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final obj = ForgotEmailModel.fromJson(jsonDecode(response.body));

      return obj;
    } else {
      final reason = handleError(response.body);
      if (reason.isEmpty) {
        throw Exception("unable to reach now.");
      }
      throw Exception(reason);
    }
  }

  Future<dynamic> forgotOtp({
    required String otpCode,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      "otp": otpCode,
    });

    final response = await http.post(
      Uri.parse('$_BASE_URL${AppConfig.forgotOtp}'),
      headers: headers,
      body: body,
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final obj = ForgotOtpModel.fromJson(jsonDecode(response.body));

      return obj;
    } else {
      final reason = handleError(response.body);
      if (reason.isEmpty) {
        throw Exception("unable to reach now.");
      }
      throw Exception(reason);
    }
  }

  Future<dynamic> changePassword({
    required String password,
    required String otpCode,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({"password": password, "otp": otpCode});

    final response = await http.patch(
      Uri.parse('$_BASE_URL${AppConfig.changePass}'),
      headers: headers,
      body: body,
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final obj = ChangePassModel.fromJson(jsonDecode(response.body));

      return obj;
    } else {
      final reason = handleError(response.body);
      if (reason.isEmpty) {
        throw Exception("unable to reach now.");
      }
      throw Exception(reason);
    }
  }

  String handleError(String jsonString) {
    Map<String, dynamic> responseData = jsonDecode(jsonString);
    // print("body ${responseData["reason"]}");
    final reason = responseData["reason"] as String;
    if (reason.isEmpty) {
      return "unable to reach now.";
    }
    return reason;
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    print(fullToken);

    return fullToken ?? "";
  }
}
