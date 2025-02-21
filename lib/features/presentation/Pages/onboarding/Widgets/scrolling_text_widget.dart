import 'package:bookstagram/app_settings/components/label.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ScrollingTextRow extends StatefulWidget {
  final List<String> items;
  final bool moveLeft;

  const ScrollingTextRow(
      {super.key, required this.items, this.moveLeft = true});

  @override
  _ScrollingTextRowState createState() => _ScrollingTextRowState();
}

class _ScrollingTextRowState extends State<ScrollingTextRow> {
  late ScrollController _scrollController;
  late Timer _timer;
  double _scrollSpeed = 2.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_scrollController.hasClients) return;

      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double minScrollExtent = _scrollController.position.minScrollExtent;

      double newOffset = widget.moveLeft
          ? _scrollController.offset + _scrollSpeed // Move right to left
          : _scrollController.offset - _scrollSpeed; // Move left to right

      if (newOffset >= maxScrollExtent) {
        // Reset to beginning for seamless scrolling
        _scrollController.jumpTo(minScrollExtent);
      } else if (newOffset <= minScrollExtent) {
        // Reset to end for seamless reverse scrolling
        _scrollController.jumpTo(maxScrollExtent);
      } else {
        _scrollController.animateTo(
          newOffset,
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount:
            widget.items.length * 10, // Increased count for seamless scrolling
        itemBuilder: (context, index) {
          String text = widget.items[index % widget.items.length];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Label(
                txt: text,
                type: TextTypes.f_18_400,
              ),
            ),
          );
        },
      ),
    );
  }
}
