import 'dart:convert';
import 'dart:typed_data';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:epub_reader_highlight/epub_reader_highlight.dart';
import 'package:epub_reader_highlight/data/models/selected_text_model.dart';
import 'package:epub_reader_highlight/ui/actual_chapter.dart';
import 'package:epub_reader_highlight/ui/table_of_contents.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:async';

import '../../../bookstudy/controllers/book_market_controller.dart';
import '../../../collection_and_summary/controller/reading_now_controller.dart';
import '../../models/ReadProgressModel.dart';

class EpubReaderWidget extends StatefulWidget {
  final String? epubUrl;

  const EpubReaderWidget({super.key, this.epubUrl});

  @override
  State<EpubReaderWidget> createState() => _EpubReaderWidgetState();
}

class _EpubReaderWidgetState extends State<EpubReaderWidget> {
  EpubController? _epubReaderController;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadEpubFromNetwork();
  }

  @override
  void dispose() {
    _epubReaderController?.dispose();
    super.dispose();
  }

  Future<void> _loadEpubFromNetwork() async {
    final String? filePath = Get.arguments['file'];
    if (filePath == null || filePath.isEmpty) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
      Get.snackbar('Error', 'No valid EPUB file path provided');
      return;
    }

    final String epubUrl = "${AppConfig.imgBaseUrl}$filePath";
    print('Fetching EPUB from: $epubUrl');

    try {
      final response = await http.get(Uri.parse(epubUrl)).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out while fetching EPUB');
        },
      );
      if (response.statusCode == 200) {
        final Uint8List epubBytes = response.bodyBytes;
        try {
          final document = EpubDocument.openData(epubBytes);
          if (mounted) {
            setState(() {
              print('EpubController initialized successfully');
              _epubReaderController = EpubController(document: document);
              _isLoading = false;
            });
            // Add listener to debug currentValueListenable
            _epubReaderController!.currentValueListenable.addListener(() {
              print(
                  'currentValueListenable updated: ${_epubReaderController!.currentValueListenable.value?.chapter?.Title ?? "null"}');
            });
          }
        } catch (e, s) {
          print('❌ Error parsing EPUB document: $e');
          print(s);
          if (mounted) {
            setState(() {
              _hasError = true;
              _isLoading = false;
            });
          }
          Get.snackbar('Error', 'Failed to parse EPUB document: $e');
        }
      } else {
        print('❌ Failed to load EPUB file. Status: ${response.statusCode}');
        if (mounted) {
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        }
        Get.snackbar(
          'Error',
          'Failed to load EPUB: Status ${response.statusCode}',
        );
      }
    } catch (e, s) {
      print('❌ Error loading EPUB from network: $e');
      print(s);
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
      Get.snackbar('Error', 'Error loading EPUB: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Build called: _isLoading=$_isLoading, _hasError=$_hasError, _epubReaderController=${_epubReaderController != null}');

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_hasError || _epubReaderController == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Failed to load EPUB.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: _epubReaderController!,
          builder: (chapterValue) {
            final title = chapterValue?.chapter?.Title ?? '';
            print('EpubViewActualChapter title in builder: $title');
            return Text(
              'Chapter: $title',
              textAlign: TextAlign.start,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            );
          },
          loader: const Text(
            '',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(controller: _epubReaderController!),
      ),
      body: EpubView(
        controller: _epubReaderController!,
        replacedParagraphs: [],
        builders: EpubViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(
            textStyle: TextStyle(fontSize: 16, height: 1.5),
          ),
          chapterDividerBuilder: (_) => const Divider(),
        ),
        onHighlightTap: (SelectedTextModel selectedTextModel) {
          print('Highlighted Text: $selectedTextModel');
          _showHighlightDialog(context, selectedTextModel);
        },
        onPagePrint: (chapterIndex, pageIndex) {
          // Your custom function logic here
          ReadProgress(chapterIndex, pageIndex);
          debugPrint(
              'Custom: Rendering Chapter $chapterIndex, Page $pageIndex');
          // Example: Log to a file, send to analytics, update UI, etc.
        },
        paragraphIndexOnDispose: (int paragraphIndex) {
          print('Last Paragraph Index: $paragraphIndex');
        },
      ),
    );
  }

  Future<void> ReadProgress(int page, int totalpages) async {
    try {
      var data = await postOrderBooks(page, totalpages);

      Get.put(PgBookmarketController()).fetchBookStudy();
      Get.put(PgReadingBooksController()).GetAllReadBooks();
    } catch (e) {
      print("Error fetching books: $e");
    }
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<progressReadResponseModel> postOrderBooks(
      num page, num totalpages) async {
    try {
      final token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'role': 'admin',
        'x-client-type': 'mobile',
      };
      HttpWithMiddleware httpClient = HttpWithMiddleware.build(
        middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
      );
      final double progress = ((page + 1) / totalpages) * 100;
      String uri =
          '${AppConfig.baseUrl}${AppConfig.CompeteLesson}/${Get.arguments["id"]}';
      final response = await httpClient.put(Uri.parse(uri),
          headers: headers,
          body: jsonEncode({
            "progress": progress,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return progressReadResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void _showHighlightDialog(
    BuildContext context,
    SelectedTextModel selectedText,
  ) {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Highlight Details'),
          content: Text('Selected Text: ${selectedText.selectedText}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Edit Highlight'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
