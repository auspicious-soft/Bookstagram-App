import 'package:get/get.dart';

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
}
