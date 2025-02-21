import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/features/presentation/Pages/BookRooomScreens/CompletedBooks/pg_completed_books.dart';
import 'package:bookstagram/features/presentation/Pages/BookRooomScreens/FavoriteAuthor/pg_favorite_author.dart';
import 'package:bookstagram/features/presentation/Pages/BookRooomScreens/FavoriteBooks/pg_favorite_books.dart';
import 'package:bookstagram/features/presentation/Pages/BookRooomScreens/ReadingBook/pg_reading_books.dart';
import 'package:bookstagram/features/presentation/Pages/BookRooomScreens/YourCourse/pg_your_course.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgBookRoom extends StatefulWidget {
  const PgBookRoom({super.key});

  @override
  State<PgBookRoom> createState() => _PgBookRoomState();
}

class _PgBookRoomState extends State<PgBookRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  AppAssets.bookroom,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 15,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 4.1,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PgReadingBooks(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.read,
                                  fit: BoxFit.contain,
                                  width: 24,
                                  height: 24,
                                ),
                                padHorizontal(15),
                                Label(
                                    txt: AppLocalization.of(context)
                                        .translate('readingnow'),
                                    type: TextTypes.f_22_400),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
                            )
                          ],
                        )),
                    padVertical(40),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PgFavoriteBooks(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.unlike,
                                  fit: BoxFit.contain,
                                  width: 24,
                                  height: 24,
                                ),
                                padHorizontal(15),
                                Label(
                                    txt: AppLocalization.of(context)
                                        .translate('favoritebooks'),
                                    type: TextTypes.f_22_400),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
                            )
                          ],
                        )),
                    padVertical(40),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PgCompletedBooks(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.combook,
                                fit: BoxFit.contain,
                                width: 24,
                                height: 24,
                              ),
                              padHorizontal(15),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('completedbooks'),
                                  type: TextTypes.f_22_400),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                    padVertical(40),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PgFavoriteAuthor(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.favaut,
                                  fit: BoxFit.contain,
                                  width: 24,
                                  height: 24,
                                ),
                                padHorizontal(15),
                                Label(
                                    txt: AppLocalization.of(context)
                                        .translate('favoriteauthors'),
                                    type: TextTypes.f_22_400),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
                            )
                          ],
                        )),
                    padVertical(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.audio,
                              fit: BoxFit.contain,
                              width: 24,
                              height: 24,
                            ),
                            padHorizontal(15),
                            Label(
                                txt: AppLocalization.of(context)
                                    .translate('audioplayer'),
                                type: TextTypes.f_22_400),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                        )
                      ],
                    ),
                    padVertical(40),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PgYourCourse(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.courseaudio,
                                  fit: BoxFit.contain,
                                  width: 24,
                                  height: 24,
                                ),
                                padHorizontal(15),
                                Label(
                                    txt: AppLocalization.of(context)
                                        .translate('yourcourses'),
                                    type: TextTypes.f_22_400),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
                            )
                          ],
                        )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
