import 'dart:async';
import 'dart:convert';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/features/data/datasources/network_error.dart';
import 'package:bookstagram/features/data/models/blog_model.dart';
import 'package:bookstagram/features/data/models/change_pass_model.dart';
import 'package:bookstagram/features/data/models/collection_model.dart';
import 'package:bookstagram/features/data/models/forgot_email_model.dart';
import 'package:bookstagram/features/data/models/forgot_otp_model.dart';
import 'package:bookstagram/features/data/models/homedata_model.dart';
import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/data/models/signup_model.dart';
import 'package:bookstagram/features/data/models/stock_model.dart';
import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/otp_resend_model.dart';
import '../modules/home_module/models/blog_collection_model.dart';

/// Custom HTTP Client with Pretty Logger
class LoggingHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    print('\x1B[33m➡️ Request: ${request.method} ${request.url}');
    request.headers.forEach((key, value) {
      print('  🟡 $key: $value');
    });

    if (request is http.Request && request.body.isNotEmpty) {
      try {
        final prettyBody = const JsonEncoder.withIndent('  ')
            .convert(jsonDecode(request.body));
        print('  📦 Body:\n$prettyBody');
      } catch (e) {
        print('  📦 Raw Body: ${request.body}');
      }
    }

    final response = await _inner.send(request);
    final responseBody = await response.stream.bytesToString();

    print('\x1B[32m⬅️ Response: ${response.statusCode} ${request.url}');
    try {
      final prettyResponse =
          const JsonEncoder.withIndent('  ').convert(jsonDecode(responseBody));
      print('  🟢 Response Body:\n$prettyResponse');
    } catch (e) {
      print('  🟢 Raw Response: $responseBody');
    }

    return http.StreamedResponse(
      Stream.value(utf8.encode(responseBody)),
      response.statusCode,
      headers: response.headers,
      request: response.request,
      reasonPhrase: response.reasonPhrase,
    );
  }
}

/// Remote Data Source with API integrations
class RemoteDs {
  final _BASE_URL = AppConfig.baseUrl;
  final _client = LoggingHttpClient();

  Future<dynamic> loginToBookstagram({
    required String email,
    required String pass,
    required String phoneNumber,
    required String language,
    required String fullName,
    required String profilePic,
    required String authType,
  }) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "email": email,
      "password": pass,
      "phoneNumber": phoneNumber,
      "fullName": {"eng": fullName},
      "profilePic": profilePic,
      "language": language,
      "authType": authType
    });

    final response = await _client.post(
      Uri.parse('$_BASE_URL${AppConfig.signIn}'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(handleError(response.body));
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
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "email": email,
      "countryCode": countryCode,
      "phoneNumber": phoneNumber,
      "fullName": {"eng": fullname},
      "firstName": {"eng": firstname},
      "lastName": {"eng": lastname},
      "password": pass,
      "language": language,
      "authType": authType,
    });

    final response = await _client.post(
      Uri.parse('$_BASE_URL${AppConfig.signUp}'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return SignUpModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(handleError(response.body));
    }
  }

  Future<dynamic> verifySignupOtp({
    required String email,
    required String otpCode,
  }) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({"email": email, "otp": otpCode});

    final response = await _client.post(
      Uri.parse('$_BASE_URL${AppConfig.verifySignUp}'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return VerificationOtpModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(handleError(response.body));
    }
  }

  Future<dynamic> forgotEmail({required String email}) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({"email": email});

    final response = await _client.post(
      Uri.parse('$_BASE_URL${AppConfig.forgotEmail}'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return ForgotEmailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(handleError(response.body));
    }
  }

  Future<dynamic> resendOtp({required String email}) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({"email": email});

    final response = await _client.post(
      Uri.parse('$_BASE_URL${AppConfig.resendOtp}'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return resendModal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(handleError(response.body));
    }
  }

  Future<dynamic> forgotOtp({required String otpCode}) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({"otp": otpCode});

    final response = await _client.post(
      Uri.parse('$_BASE_URL${AppConfig.forgotOtp}'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return ForgotOtpModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(handleError(response.body));
    }
  }

  Future<dynamic> changePassword({
    required String password,
    required String otpCode,
  }) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({"password": password, "otp": otpCode});

    final response = await _client.patch(
      Uri.parse('$_BASE_URL${AppConfig.changePass}'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return ChangePassModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(handleError(response.body));
    }
  }

  Future<dynamic> getHomeData() async {
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'role': 'admin',
      'x-client-type': 'mobile',
    };

    final response = await _client.get(
      Uri.parse('$_BASE_URL${AppConfig.getHomeData}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return HomeDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(handleError(response.body));
    }
  }

  Future<dynamic> getProductByType({required String type}) async {
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'role': 'admin',
      'x-client-type': 'mobile',
    };

    final response = await _client.get(
      Uri.parse('$_BASE_URL${AppConfig.getproductByType}$type'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      if (type == "stock") {
        return StockModel.fromJson(jsonMap);
      } else if (type == "blog") {
        return BlogCollectionModel.fromJson(jsonMap);
      } else {
        return CollectionModel.fromJson(jsonMap);
      }
    } else {
      throw Exception(handleError(response.body));
    }
  }

  String handleError(String jsonString) {
    final Map<String, dynamic> responseData = jsonDecode(jsonString);
    return responseData["reason"] ?? "User not Found";
  }

  Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token ?? "";
  }
}
