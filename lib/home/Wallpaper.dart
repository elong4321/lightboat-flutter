import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lightboat/System.dart';
import 'package:lightboat/landscape/Landscape.dart';
import 'package:nil/nil.dart';

class WallPaper extends StatefulWidget {
  static const NOMARL = 1;
  static const BLURRED= 2;

  int status;

  WallPaper({this.status = NOMARL});

  createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {
  double blurSigma = 12;
  Landscape? landscape;

  @override
  void initState() {
    super.initState();
    loadLandscape();
  }

  @override
  Widget build(BuildContext context) {
    Widget? p = phraseWidget();
    return SizedBox(width: double.infinity, height: double.infinity, child: Stack(
      children: [
        Positioned.fill(child:image()),
        if (widget.status == WallPaper.BLURRED)
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurSigma,
              sigmaY: blurSigma,
            ),
            child: Container()),
        if (p != null) p,
      ],
    ));
  }

  void loadLandscape() async {
    if (landscape == null) {
      String str = await rootBundle.loadString("assets/landscape/1.json");
      Map<String, dynamic> map = jsonDecode(str);
      landscape = Landscape(map);
    }
    if (mounted) {
      setState(() {});
    }
  }

  Widget image() {
    return landscape?.image != null ? Image.asset(landscape!.image, fit: BoxFit.cover,) 
      : Image.asset("assets/images/poetry_boat.jpg", fit: BoxFit.cover,);
  }

  Widget? phraseWidget() {
    Widget? w = landscape?.phrase != null ? Text(landscape!.phrase,
        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w100, height: 1.8),) : null;
    bool blurred = widget.status == WallPaper.NOMARL;
    if (w != null) {
      w = Container(
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: blurred ? BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white.withOpacity(0.1)) : null,
        child: w,
      );
    }
    if (w != null && blurred) {
      w = ClipRRect(
        borderRadius: BorderRadius.circular(10), 
        child: Stack(
          children: [
            w,
            BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurSigma,
              sigmaY: blurSigma,
            ),)
          ],
        ) 
      );
    }
    if (w != null) {
      w = Align(alignment: Alignment.bottomCenter, child: w,);
    }
    return w;
  }
}