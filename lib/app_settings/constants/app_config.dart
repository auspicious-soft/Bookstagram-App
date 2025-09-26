class AppConfig {
  // static const String baseUrl = "https://duman-backend.onrender.com/";

  static const String baseUrl = "https://9f370faebf96.ngrok-free.app/";
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
  static const String getCourseById = 'api/user/course';
  static const String getCourseLessons = 'api/user/course-lessons';
  static const String imgBaseUrl =
      'https://bookstagram-bucket-1.s3.eu-north-1.amazonaws.com/';

  static const String getBookMarketHome = 'api/user/book-market';
  static const String getBookbyIdEndPoints = 'api/user/books';
  static const String postOrdersEndPoints = 'api/user/order';
  static const String getEventHome = 'api/user/events';
  static const String getBookLives = 'api/user/book-lives';
  static const String CompeteLesson = 'api/user/read-progress';
  static const String AddToCartEndPoints = 'api/user/cart';
  static const String AudioChapterEndPoints = 'api/user/audiobook';
  static const String ReviewsEndPoints = 'api/user/books/rating';
  static const String GernateCertificate = 'api/user/generate-certificate';
  static const String GetCertificate = 'api/user/certificate';
  static const String postLikeEndPoint = 'api/user/favourites';
  static const String SettingProfileEndPoint = 'api/user/user-details';
  static const String MediaUploadEndPoint = 'api/user/upload-image';
  static const String editProfileEndPoint = 'api/user/user-details';
  static const String getAchievementsEndPoint = 'api/user/get-badge';
  static const String getBestSellers = 'api/user/best-sellers';
  static const String getAllNewBooks = 'api/user/new-books';
  static const String getAllAudioBooksEndPoints = 'api/user/audiobooks';
  static const String getAllPublishers = 'api/user/publishers';
  static const String getCollectionDetailEndPoint = 'api/user/collections';
  static const String getAllSummariesEndPoint = 'api/user/summaries';
  static const String getReadingNowEndPoint = 'api/user/book-rooms/reading-now';
  static const String getAllFavouriteEndPoint =
      "api/user/book-rooms/favourite-books";
  static const String getAllCompletedBooksEndPoint =
      "api/user/book-rooms/finished-books";

  static const String getAllFavouriteAuthorsEndPoint =
      "api/user/author-favourites";

  static const String AddAuthorFavouriteEndPoint = 'api/user/author-favourites';

  static const String CourseFavouriteEndPoint = 'api/user/book-rooms/courses';

  static const String VerifyCouponEndPoint = 'api/user/book-schools/verify';
  static const String BookSchoolBooksEndPoint = 'api/user/book-schools/books';
  static const String ProfilePasswordChange = 'api/user/change-password';
  static const String WalletHistory = 'api/user/wallet-history';
  static const String FAQEndPoints = 'api/user/faqs';
  static const String NotificationSettingEndPoint = 'api/user/user-language';
  static const String StaticData = 'api/user/policies';
}
