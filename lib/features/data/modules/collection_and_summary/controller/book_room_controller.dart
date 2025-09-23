import 'package:get/get.dart';

class PgBookRoomController extends GetxController {
  // Navigation methods
  void goToReadingBooks() {
    Get.toNamed("/reading-books");
  }

  void goToFavoriteBooks() {
    Get.toNamed("/favourite-books");
  }

  void goToCompletedBooks() {
    Get.toNamed("/complete-books");
  }

  void goToFavoriteAuthors() {
    Get.toNamed("/my-all-favourite-authors");
  }

  void goToYourCourses() {
    Get.toNamed("/favourite-courses");
  }

  void goToAudioPlayer() {
    Get.snackbar('Info', 'Audio Player navigation not implemented yet.');
  }
}
