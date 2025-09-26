import 'package:get/get.dart';

class NotificationModel {
  final String title;
  final String subtitle;
  final bool isUnread;

  NotificationModel({
    required this.title,
    required this.subtitle,
    this.isUnread = false,
  });
}

class PgNotificationController extends GetxController {
  final notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with dummy data
    notifications.assignAll([
      NotificationModel(
        title: "Welcome to Bookstagram!",
        subtitle: "Thanks for joining our community.",
        isUnread: true,
      ),
      NotificationModel(
        title: "New Book Recommendation",
        subtitle: "Check out the latest book picks.",
        isUnread: true,
      ),
      NotificationModel(
        title: "Friend Request",
        subtitle: "John Doe sent you a friend request.",
        isUnread: false,
      ),
      NotificationModel(
        title: "Book Club Invite",
        subtitle: "Join our monthly book club meeting.",
        isUnread: false,
      ),
      NotificationModel(
        title: "New Comment",
        subtitle: "Someone commented on your post.",
        isUnread: false,
      ),
      NotificationModel(
        title: "App Update Available",
        subtitle: "Update to the latest version for new features.",
        isUnread: false,
      ),
      NotificationModel(
        title: "Reading Challenge",
        subtitle: "Join the 2025 reading challenge!",
        isUnread: false,
      ),
      NotificationModel(
        title: "Book Review",
        subtitle: "Your review has been published.",
        isUnread: false,
      ),
      NotificationModel(
        title: "Follow Update",
        subtitle: "Jane Smith started following you.",
        isUnread: false,
      ),
      NotificationModel(
        title: "Event Reminder",
        subtitle: "Book signing event this weekend.",
        isUnread: false,
      ),
      NotificationModel(
        title: "New Message",
        subtitle: "You have a new message from Alex.",
        isUnread: false,
      ),
      NotificationModel(
        title: "Profile Update",
        subtitle: "Your profile picture has been updated.",
        isUnread: false,
      ),
      NotificationModel(
        title: "Community Guidelines",
        subtitle: "Please review our updated guidelines.",
        isUnread: false,
      ),
      NotificationModel(
        title: "Book Sale",
        subtitle: "Limited time offer on bestsellers.",
        isUnread: false,
      ),
      NotificationModel(
        title: "Feedback Request",
        subtitle: "Share your thoughts on the app.",
        isUnread: false,
      ),
    ]);
  }
}
