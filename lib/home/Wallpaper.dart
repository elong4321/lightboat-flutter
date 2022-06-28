import 'dart:ui';

import 'package:flutter/material.dart';

class WallPaper extends StatefulWidget {
  static const NOMARL = 1;
  static const BLURRED= 2;

  int status;

  WallPaper({this.status = NOMARL});

  createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset("assets/images/poetry_boat.jpg", fit: BoxFit.cover,)),
        BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.status == WallPaper.BLURRED ? 12 : 0,
              sigmaY: widget.status == WallPaper.BLURRED ? 12 : 0,
            ),
            child: Container()),
      ],
    );
  }
}