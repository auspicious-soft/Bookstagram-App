import 'package:get/get.dart';

class PgCollectionsController extends GetxController {
  // Reactive list to track like status for each item
  final RxList<bool> likeStatus = RxList<bool>([false, false, false]);
  var title="".obs;

  void toggleLike(int index) {
    if (index >= 0 && index < likeStatus.length) {
      likeStatus[index] = !likeStatus[index];
    }
  }

  // Optional: Initialize or fetch data (e.g., from API)
  @override
  void onInit() {
    super.onInit();
    if(Get.arguments!=null){
      title.value=Get.arguments["title"];
    }
    // If data is dynamic, fetch collections here
    // Example: fetchCollections();
  }

  // Optional: Method to fetch collections (placeholder for future API integration)
  Future<void> fetchCollections() async {
    // TODO: Implement API call to fetch collections
    // Example:
    // try {
    //   final response = await apiRepository.getCollections();
    //   likeStatus.assignAll(List.generate(response.length, (_) => false));
    // } catch (e) {
    //   Get.snackbar('Error', 'Failed to load collections');
    // }
  }
}