import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../models/wallet_history_response_model.dart';

class PgBalanceScreenController extends GetxController {
  final RxInt balance = 0.obs;
  final RxInt cashback = 20.obs;
  final RxList<Map<String, dynamic>> history = [
    {
      'name': 'Operation name',
      'date': '19.11.2024 02:12',
      'amount': '+35 ₸',
    },
    {
      'name': 'Operation name',
      'date': '19.11.2024 02:12',
      'amount': '+35 ₸',
    },
  ].obs;

  final RxBool isLoading = true.obs;
  final Rx<walletHistoryResponseModel?> walletHistory =
      Rx<walletHistoryResponseModel?>(null);
  var filter = "default".obs;

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  @override
  void onInit() {
    fetchWalletHistory();
    super.onInit();
  }

  Future<void> fetchWalletHistory({String? month, String? year}) async {
    isLoading.value = true;
    try {
      var data = await getHistory(month: month, year: year);
      walletHistory.value = data;

      walletHistory.refresh();
      print("Books found: ${walletHistory.value?.data?.history?.length ?? 0}");
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<walletHistoryResponseModel> getHistory(
      {String? month, String? year}) async {
    try {
      final token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'role': 'admin',
        'x-client-type': 'mobile',
      };

      HttpWithMiddleware httpClient = HttpWithMiddleware.build(
        middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
      );

      // Base URL
      final uri = Uri.parse('${AppConfig.baseUrl}${AppConfig.WalletHistory}');

      // Build query parameters map
      final queryParams = <String, String>{};

      if (month != null && month.isNotEmpty) {
        queryParams['month'] = month;
      }
      if (year != null && year.isNotEmpty) {
        queryParams['year'] = year;
      }

      // Add query parameters if any
      final finalUri = uri.replace(
          queryParameters: queryParams.isNotEmpty ? queryParams : null);

      final response = await httpClient.get(
        finalUri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return walletHistoryResponseModel.fromJson(jsonBody);
      } else {
        throw Exception(
            'Failed to fetch wallet history: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }
}
