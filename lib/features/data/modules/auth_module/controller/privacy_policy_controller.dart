import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  var title="".obs;
  @override
  void onInit() {
   if(Get.arguments!=null){
     title.value=Get.arguments["title"];
   }
    super.onInit();
  }
  // Static HTML content for the Privacy Policy
  final String privacyPolicyHtml = """

    <p>At Bookstagram, we respect and protect the privacy of our users. This Privacy Policy outlines the types of personal information we collect, how we use it, and how we protect your information.</p>
    
    <h3>Information We Collect</h3>
    <p>When you use our app, we may collect the following types of personal information:</p>
    <ul>
      <li><b>Device Information:</b> We may collect information about the type of device you use, its operating system, and other technical details to help us improve our app.</li>
      <li><b>Usage Information:</b> We may collect information about how you use our app, such as which features you use and how often you use them.</li>
      <li><b>Personal Information:</b> We may collect personal information, such as your name, email address, or phone number, if you choose to provide it to us.</li>
    </ul>
    
    <h3>How We Use Your Information</h3>
    <p>We use your information for the following purposes:</p>
    <ul>
      <li><b>To provide and improve our app:</b> We use your information to provide and improve our app, including to personalize your experience and to analyze how our app is used.</li>
      <li><b>To communicate with you:</b> We may use your information to communicate with you about our app, including to provide you with updates and news about our app.</li>
      <li><b>To protect our rights and the rights of others:</b> We may use your information to protect our rights and the rights of others, such as to investigate and prevent fraud or other illegal activity.</li>
    </ul>
  """;
}