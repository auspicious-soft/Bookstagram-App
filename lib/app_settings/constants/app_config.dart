class AppConfig {
  static const String signIn = 'api/user-login';
  static const String signUp = 'api/user-signup';
  static const String verifySignUp = 'api/user-verify-otp';
  static const String forgotEmail = 'api/user-forgot-password';
  static const String forgotOtp = 'api/verify-otp';
  static const String changePass = 'api/user-new-password-otp-verified';
  static const String getHomeData = 'api/user/home-page';
  static const String getproductByType = 'api/user/home-page/products?type=';
  static const String imgBaseUrl =
      'https://bookstagram-bucket-1.s3.eu-north-1.amazonaws.com/';
}
