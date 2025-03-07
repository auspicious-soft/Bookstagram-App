import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/data/datasources/user_storage.dart';
import 'package:bookstagram/features/presentation/Pages/Dashboard/pg_dasboard.dart';
import 'package:bookstagram/features/presentation/Pages/chooselanguage/pg_chooselan.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    inIt();
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const PgChooselan()),
    //   );
    // });
  }

  void inIt() async {
    // UserStorage.con.deleteToken();
    final token = await UserStorage.con.getToken();

    if (token.isEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PgChooselan()),
        );
      });
      print("on");
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PgDashBoard()),
        );
      });
      print("dash");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.asset(
            AppAssets.splashimg,
            height: MediaQuery.of(context).size.height,
          )),
        ],
      ),
    );
  }
}
