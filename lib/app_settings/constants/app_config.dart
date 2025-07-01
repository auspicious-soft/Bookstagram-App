class AppConfig {
  // static const String baseUrl = "https://duman-backend.onrender.com/";
  static const String baseUrl = "https://1bd3-103-223-15-43.ngrok-free.app/";
  static const String signIn = 'api/user-login';
  static const String signUp = 'api/user-signup';
  static const String verifySignUp = 'api/user-verify-otp';
  static const String forgotEmail = 'api/user-forgot-password';
  static const String resendOtp = 'api/resend-otp';
  static const String forgotOtp = 'api/verify-otp';
  static const String changePass = 'api/user-new-password-otp-verified';
  static const String getHomeData = 'api/user/home-page';
  static const String getproductByType = 'api/user/home-page/products?type=';
  static const String getBooksEndPoints = 'api/user/books';
  static const String getAuthorsEndPoints = 'api/user/authors';
  static const String forgetResend = 'api/forgotpassword-resend-otp';
  static const String getBookStudHome = 'api/user/books-studies';
  static const String getBookUniHome = 'api/user/books-universities';
  static const String getBookMasterHome = 'api/user/books-masters';
  static const String getCategories = 'api/user/books-studies/categories';
  static const String getAllTeachers = 'api/user/books-studies/teachers';
  static const String getTeacherById = 'api/user/authors';
  static const String getCategoryById = 'api/user/categories';
  static const String imgBaseUrl =
      'https://bookstagram-bucket-1.s3.eu-north-1.amazonaws.com/';

  static const String getBookMarketHome = 'api/user/book-market';

  static const String getEventHome = 'api/user/events';
  static const String getBookLives = 'api/user/book-lives';
}
