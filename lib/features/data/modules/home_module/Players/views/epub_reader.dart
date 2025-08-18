import 'dart:typed_data';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:epub_reader_highlight/epub_reader_highlight.dart';
import 'package:epub_reader_highlight/data/models/selected_text_model.dart';
import 'package:epub_reader_highlight/ui/actual_chapter.dart';
import 'package:epub_reader_highlight/ui/table_of_contents.dart';

class EpubReaderWidget extends StatefulWidget {
  const EpubReaderWidget({super.key});

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

  Future<void> _loadEpubFromNetwork() async {
    const epubUrl =
        '${AppConfig.imgBaseUrl}books/cameron-kemp/files/kaz/Alices Adventures in Wonderland.epub'; // <- change this

    try {
      final response = await http.get(Uri.parse(epubUrl));
      if (response.statusCode == 200) {
        final Uint8List epubBytes = response.bodyBytes;

        setState(() {
          _epubReaderController = EpubController(
            document: EpubDocument.openData(epubBytes),
          );
          _isLoading = false;
        });
      } else {
        print('❌ Failed to load EPUB file. Status: ${response.statusCode}');
        setState(() {
          _hasError = true;
        });
      }
    } catch (e, s) {
      print('❌ Error loading EPUB from network: $e');
      print(s);
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _epubReaderController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError || _epubReaderController == null) {
      return const Center(child: Text('Failed to load EPUB.'));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: _epubReaderController!,
          builder: (chapterValue) => Text(
            'Chapter: ${chapterValue?.chapter?.Title}',
            textAlign: TextAlign.start,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: _epubReaderController!,
        ),
      ),
      body: EpubView(
        controller: _epubReaderController!,
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
        paragraphIndexOnDispose: (int paragraphIndex) {
          print('Last Paragraph Index: $paragraphIndex');
        },
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reader Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Adjust settings like font size or reading mode.'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Apply'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showHighlightDialog(
      BuildContext context, SelectedTextModel selectedText) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
    );
  }
}
