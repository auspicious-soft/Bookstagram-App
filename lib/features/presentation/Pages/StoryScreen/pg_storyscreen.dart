import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';

import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';

import 'package:bookstagram/features/data/models/homedata_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PgStoryscreen extends StatefulWidget {
  final Story story;

  const PgStoryscreen({super.key, required this.story});

  @override
  State<PgStoryscreen> createState() => _PgStoryscreenState();
}

class _PgStoryscreenState extends State<PgStoryscreen> {
  late List<String> storyImages;
  late List<String> storyLinks;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Extract image paths (keys) and links (values) separately
    if (widget.story.file != null) {
      storyImages = widget.story.file!.keys.toList(); // Get image keys
      storyLinks = widget.story.file!.values.toList(); // Get site links
    } else {
      storyImages = [];
      storyLinks = [];
    }
  }

  void _nextStory() {
    if (currentIndex < storyImages.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _nextStory, // Tap to move to the next story
      child: Scaffold(
          backgroundColor: AppColors.blackColor,
          body: SafeArea(
            child: WidgetGlobalMargin(
              child: Column(
                children: [
                  // Story progress indicators
                  Row(
                    children: List.generate(storyImages.length, (index) {
                      return Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: EdgeInsets.only(
                              right: index < storyImages.length - 1 ? 4 : 0),
                          height: 4,
                          decoration: BoxDecoration(
                            color: index <= currentIndex
                                ? Colors.white
                                : Colors.grey[700],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 15),

                  // Close button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),

                  // Story image display
                  Expanded(
                    child: Center(
                      child: Image.network(
                        "${AppConfig.imgBaseUrl}${storyImages[currentIndex]}",
                        // Show current story image
                        height: MediaQuery.of(context).size.height / 1.3,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Follow button
                  GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse(storyLinks[
                            currentIndex]); // Open the corresponding link
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print("Could not launch $url");
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.inputBorder,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Label(
                            txt: "Follow",
                            type: TextTypes.f_17_700,
                            forceColor: Colors.white,
                          ),
                        ),
                      )).marginSymmetric(vertical: 20),
                ],
              ),
            ),
          )),
    );
  }
}
