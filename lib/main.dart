import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/data/modules/CourseModule/bindings/course_detail_binding.dart';
import 'package:bookstagram/features/data/modules/CourseModule/views/pgCourseDetailView.dart';
import 'package:bookstagram/features/data/modules/auth_module/binding/congratulations_binding.dart';
import 'package:bookstagram/features/data/modules/auth_module/binding/login_binding.dart';
import 'package:bookstagram/features/data/modules/auth_module/binding/otp_verification_binding.dart';
import 'package:bookstagram/features/data/modules/auth_module/binding/privacy_policy_binding.dart';
import 'package:bookstagram/features/data/modules/auth_module/binding/signup_binding.dart';
import 'package:bookstagram/features/data/modules/auth_module/controller/privacy_policy_controller.dart';
import 'package:bookstagram/features/data/modules/auth_module/view/login_screen.dart';
import 'package:bookstagram/features/data/modules/auth_module/view/otp_verification_screen.dart';
import 'package:bookstagram/features/data/modules/bookstudy/bindings/book_life_binding.dart';
import 'package:bookstagram/features/data/modules/bookstudy/bindings/book_market_bindings.dart';
import 'package:bookstagram/features/data/modules/bookstudy/bindings/book_master_binding.dart';
import 'package:bookstagram/features/data/modules/bookstudy/bindings/book_univerisity_binding.dart';
import 'package:bookstagram/features/data/modules/bookstudy/bindings/bookstudy_bindings.dart';
import 'package:bookstagram/features/data/modules/bookstudy/bindings/categories_bindings.dart';
import 'package:bookstagram/features/data/modules/bookstudy/bindings/categoryById_binding.dart';
import 'package:bookstagram/features/data/modules/bookstudy/bindings/teacherdetail_binding.dart';
import 'package:bookstagram/features/data/modules/bookstudy/bindings/teachers_bindings.dart';
import 'package:bookstagram/features/data/modules/bookstudy/views/book_life_view.dart';
import 'package:bookstagram/features/data/modules/bookstudy/views/book_market.dart';
import 'package:bookstagram/features/data/modules/bookstudy/views/book_masters_screen.dart';
import 'package:bookstagram/features/data/modules/bookstudy/views/book_university_screen.dart';
import 'package:bookstagram/features/data/modules/bookstudy/views/bookstudy_homeScreen.dart';
import 'package:bookstagram/features/data/modules/bookstudy/views/categories_screen.dart';
import 'package:bookstagram/features/data/modules/bookstudy/views/categorybyId_Screen.dart';
import 'package:bookstagram/features/data/modules/bookstudy/views/teachers_screen.dart';
import 'package:bookstagram/features/data/modules/collection_and_summary/bindings/fav_course_binding.dart';
import 'package:bookstagram/features/data/modules/collection_and_summary/bindings/my_all_Favourite_authors_binding.dart';
import 'package:bookstagram/features/data/modules/collection_and_summary/view/fav_course_view.dart';
import 'package:bookstagram/features/data/modules/collection_and_summary/view/my_all_FavouriteAuthors.dart';
import 'package:bookstagram/features/data/modules/home_module/Players/bindings/cart_binding.dart';
import 'package:bookstagram/features/data/modules/home_module/Players/views/cart_view.dart';
import 'package:bookstagram/features/data/modules/home_module/binding/dashboard_binding.dart';
import 'package:bookstagram/features/data/modules/home_module/view/dashboard_screen.dart';
import 'package:bookstagram/features/data/modules/splash/bindings/all_collection_binding.dart';
import 'package:bookstagram/features/data/modules/splash/bindings/onboarding_binding.dart';
import 'package:bookstagram/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/modules/CourseModule/bindings/pgcertificateBinding.dart';
import 'features/data/modules/CourseModule/views/certifcate.dart';
import 'features/data/modules/Splash/bindings/language_binding.dart';
import 'features/data/modules/Splash/bindings/splash_binding.dart';
import 'features/data/modules/Splash/views/language_view.dart';
import 'features/data/modules/Splash/views/splash_view.dart';
import 'features/data/modules/auth_module/view/PrivacyPolicyScreen.dart';
import 'features/data/modules/auth_module/view/congratulation_screen.dart';
import 'features/data/modules/auth_module/view/signup_view.dart';

import 'features/data/modules/book_detail/bindings/book_detail_binding.dart';
import 'features/data/modules/book_detail/views/book_detail.dart';
import 'features/data/modules/bookstudy/bindings/book_event_binding.dart';
import 'features/data/modules/bookstudy/bindings/bookeventdetail_binding.dart';
import 'features/data/modules/bookstudy/views/bookEventDetail.dart';
import 'features/data/modules/bookstudy/views/book_event.dart';
import 'features/data/modules/bookstudy/views/teacher_detail_screen.dart';
import 'features/data/modules/collection_and_summary/bindings/MySchoolBookListBinding.dart';
import 'features/data/modules/collection_and_summary/bindings/book_room_binding.dart';
import 'features/data/modules/collection_and_summary/bindings/book_school_bindings.dart';
import 'features/data/modules/collection_and_summary/bindings/book_school_congrats_binding.dart';
import 'features/data/modules/collection_and_summary/bindings/collection_summary_binding.dart'
    show CollectionSummaryBinding;
import 'features/data/modules/collection_and_summary/bindings/completed_books_bindings.dart';
import 'features/data/modules/collection_and_summary/bindings/favourite_books_binding.dart';
import 'features/data/modules/collection_and_summary/bindings/reading_now_binding.dart';
import 'features/data/modules/collection_and_summary/view/BookScool_Congrats.dart';
import 'features/data/modules/collection_and_summary/view/MySchoolsBookList.dart';
import 'features/data/modules/collection_and_summary/view/book_School.dart';
import 'features/data/modules/collection_and_summary/view/book_room_screen.dart';
import 'features/data/modules/collection_and_summary/view/collection_summary.dart';
import 'features/data/modules/collection_and_summary/view/completed_books.dart';
import 'features/data/modules/collection_and_summary/view/favorite_books.dart';
import 'features/data/modules/collection_and_summary/view/reading_now_screen.dart';
import 'features/data/modules/home_module/Players/bindings/audio_player_bindings.dart';
import 'features/data/modules/home_module/Players/bindings/video_player_bindings.dart';
import 'features/data/modules/home_module/Players/views/audio_player.dart';
import 'features/data/modules/home_module/Players/views/video_player_screen.dart';
import 'features/data/modules/home_module/view/aboutus_screen.dart';
import 'features/data/modules/home_module/view/search_screen.dart';
import 'features/data/modules/settingModule/bindings/balance_bindings.dart';
import 'features/data/modules/settingModule/bindings/editProfileBinding.dart';
import 'features/data/modules/settingModule/bindings/level_binding.dart';
import 'features/data/modules/settingModule/view/balance_screen.dart';
import 'features/data/modules/settingModule/view/edit_profile.dart';
import 'features/data/modules/settingModule/view/levels.dart';
import 'features/data/modules/splash/bindings/all_publishers_binding.dart';
import 'features/data/modules/splash/bindings/publisher_detail_binding.dart';
import 'features/data/modules/splash/views/all_collection_screen.dart';
import 'features/data/modules/splash/views/all_publishers_screen.dart';
import 'features/data/modules/splash/views/onboarding_screen.dart';

import 'features/data/modules/splash/views/publisher_detail_screen.dart';
import 'localization/connectivity_controller.dart';
import 'localization/no_internet_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize ConnectivityController
  final connectivityController = ConnectivityController();
  Get.put(connectivityController);

  // Check initial connectivity status
  await connectivityController.checkConnection();
  final bool isConnected = connectivityController.isConnected;

  final prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('selected_language_code');
  Locale? savedLocale;

  if (languageCode != null) {
    savedLocale = Locale(languageCode);
    Get.updateLocale(savedLocale);
  }

  // Set initial route based on connectivity
  final initialRoute = isConnected ? '/splash' : '/no-internet';

  runApp(MyApp(initialRoute: initialRoute, savedLocale: savedLocale));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final Locale? savedLocale;

  const MyApp({required this.initialRoute, this.savedLocale, Key? key})
      : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language_code', newLocale.languageCode);
    Get.updateLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return GetMaterialApp(
      title: 'Bookstagram',
      debugShowCheckedModeBanner: false,
      locale: savedLocale ?? Get.locale,
      fallbackLocale: const Locale('en', ''),
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('kk', ''),
        Locale('ru', ''),
      ],
      initialRoute: initialRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      builder: (context, child) {
        return SafeArea(
          top: false, // Respect status bar
          bottom: true, // Respect navigation bar
          // Respect right notch/edge
          child: child ?? SizedBox(), // Ensure child is not null
        );
      },
      getPages: [
        GetPage(
            name: '/splash',
            page: () => const SplashView(),
            binding: SplashBinding()),
        GetPage(
            name: '/language',
            page: () => const LanguageView(),
            binding: LanguageBinding()),
        GetPage(
            name: '/onboarding',
            page: () => PgOnboarding(),
            binding: OnboardingBinding()),
        GetPage(
            name: '/signup', page: () => PgSignup(), binding: SignupBinding()),
        GetPage(
            name: '/otpscreen',
            page: () => PgOtpVerification(),
            binding: OtpVerificationBinding()),
        GetPage(name: '/login', page: () => PgLogin(), binding: LoginBinding()),
        GetPage(
            name: '/congratulations',
            page: () => CongratulationScreen(),
            binding: CongratulationsBinding()),
        GetPage(
            name: '/dashboard',
            page: () => DashboardScreen(),
            binding: DashboardBinding()),
        GetPage(
            name: '/allcollections',
            page: () => PgCollections(),
            binding: CollectionsBinding()),
        GetPage(
            name: '/searchscreen',
            page: () => PgTabsearch(),
            binding: DashboardBinding()),
        GetPage(
            name: '/privacy',
            page: () => PrivacyPolicyScreen(),
            binding: PrivacyPolicyBinding()),
        GetPage(
          name: '/no-internet',
          page: () {
            // Retrieve connectionType from ConnectivityController
            final connectivityController = Get.find<ConnectivityController>();
            return NoInternetScreen(
              connectionType: connectivityController.getCurrentConnectionType(),
            );
          },
        ),
        GetPage(
          name: '/about',
          page: () => const PgAboutUs(),
          binding: AboutUsBinding(), // Bind the controller
        ),
        GetPage(
          name: '/AudioPlayer',
          page: () => CommonAudioScreen(),
          binding: AudioPlayerBinding(), // Bind the controller
        ),
        GetPage(
          name: '/VideoPlayer',
          page: () => VideoPlayerScreen(),
          binding: VideoPlayerBinding(), // Bind the controller
        ),
        GetPage(
          name: '/bookstudy',
          page: () => PgBookstudy(),
          binding: PgBookstudyBinding(), // Bind the controller
        ),
        GetPage(
          name: '/bookuniversity',
          page: () => BookUniversityScreen(),
          binding: BookUniverisityBinding(), // Bind the controller
        ),
        GetPage(
          name: '/bookmaster',
          page: () => BookMastersScreen(),
          binding: BookMasterBinding(), // Bind the controller
        ),
        GetPage(
          name: '/categoreies',
          page: () => PgCategory(),
          binding: PgCategoryBinding(), // Bind the controller
        ),
        GetPage(
          name: '/teacherScreen',
          page: () => PgTeachers(),
          binding: TeachersBinding(), // Bind the controller
        ),
        GetPage(
          name: '/teacherDetail',
          page: () => PgTeacherProfile(),
          binding: PgTeacherdetailBinding(), // Bind the controller
        ),
        GetPage(
          name: '/categoryById',
          page: () => CategorybyidScreen(),
          binding: CategorybyidBinding(), // Bind the controller
        ),
        GetPage(
          name: '/bookMarket',
          page: () => PgBookmarket(),
          binding: PgBookmarketBinding(), // Bind the controller
        ),
        GetPage(
          name: '/bookevent',
          page: () => PgBookEvent(),
          binding: PgBookEventBinding(), // Bind the controller
        ),
        GetPage(
          name: '/booklife',
          page: () => BookLifeView(),
          binding: BookLifeBinding(), // Bind the controller
        ),
        GetPage(
          name: '/event-detail',
          page: () => PgEventDetail(),
          binding: PgEventDetailBinding(), // Bind the controller
        ),
        GetPage(
          name: '/book-detail',
          page: () => PgBookView(),
          binding: PgBookViewBinding(), // Bind the controller
        ),
        GetPage(
          name: '/Course-detail',
          page: () => PgCoursedetail(),
          binding: PgCoursedetailBinding(), // Bind the controller
        ),
        GetPage(
          name: '/Add-to-cart',
          page: () => CartView(),
          binding: CartBinding(), // Bind the controller
        ),
        GetPage(
          name: '/certificate',
          page: () => const PgCertificate(),
          binding: PgCertificateBinding(),
        ),
        GetPage(
          name: '/editProfile',
          page: () => const PgEditProfileView(),
          binding: PgEditProfileBinding(),
        ),
        GetPage(
          name: '/levels',
          page: () => const PgAchievements(),
          binding: PgAchievementsBinding(),
        ),
        GetPage(
          name: '/balanceScreen',
          page: () => const PgBalanceScreen(),
          binding: PgBalanceScreenBinding(),
        ),
        GetPage(
          name: '/allPublishers',
          page: () => const PgPublishers(),
          binding: PublishersBinding(),
        ),
        GetPage(
          name: '/publisherDetail',
          page: () => const PublisherDetailScreen(),
          binding: PublisherDetailBinding(),
        ),
        GetPage(
          name: '/Collection_Summary',
          page: () => CollectionSummary(),
          binding: CollectionSummaryBinding(),
        ),
        GetPage(
          name: '/book_room',
          page: () => PgBookRoom(),
          binding: PgBookRoomBinding(),
        ),
        GetPage(
          name: "/reading-books",
          page: () => PgReadingBooks(),
          binding: PgReadingBooksBinding(),
        ),
        GetPage(
          name: "/favourite-books",
          page: () => PgFavoriteBooks(),
          binding: PgFavoriteBooksBinding(),
        ),
        GetPage(
          name: "/complete-books",
          page: () => CompletedBooks(),
          binding: CompletedBooksBindings(),
        ),
        GetPage(
          name: "/my-all-favourite-authors",
          page: () => MyFavoriteAuthorView(),
          binding: MyFavoriteAuthorBinding(),
        ),
        GetPage(
          name: "/favourite-courses",
          page: () => FavCourseView(),
          binding: FavCourseBinding(),
        ),
        GetPage(
          name: "/book-schoolCoupon",
          page: () => PgBookSchool(),
          binding: PgBookSchoolBinding(),
        ),
        GetPage(
          name: "/book-school-congrats",
          page: () => BookschoolCongrats(),
          binding: BookSchoolCongratsBinding(),
        ),
        GetPage(
          name: "/book-school-List",
          page: () => Myschoolsbooklist(),
          binding: Myschoolbooklistbinding(),
        ),
      ],
    );
  }
}
