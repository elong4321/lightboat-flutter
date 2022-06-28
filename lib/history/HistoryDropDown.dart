import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nil/nil.dart';

import '../style/Style.dart';

class HistoryDropDown extends StatelessWidget {
  List<String>? histories = null;
  Offset? offset;
  double width;

  HistoryDropDown(this.histories, {this.width = 400, this.offset});
  
  @override
  Widget build(BuildContext context) {
    return histories != null && (histories?.isNotEmpty ?? false) ?
      Container(width: width, margin: EdgeInsets.only(top: offset?.dy ?? 0, left: offset?.dx ?? 0),
          child: Material(color: Colors.transparent,
              child: Wrap(spacing: 5, runSpacing: 10,
                  children:List.generate(histories!.length,
                          (index) { return _HistoryItem(histories![index]); }))
      )) : nil;
  }
}

class _HistoryItem extends StatelessWidget {
  final String text;

  _HistoryItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      constraints: BoxConstraints(maxWidth: 100),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white.withOpacity(0.7)),
      child: Text(text, style: TextStyle(fontSize: 14, color: Style.mainTextColor), overflow: TextOverflow.ellipsis,),
    );
  }
}