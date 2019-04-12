import 'package:flutter/material.dart';

class CommentPlaceholder extends StatelessWidget {
  int level;
  CommentPlaceholder(this.level) {
    level = this.level ?? 1;
  }
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 4, color: getColor(level ?? 1)),
            bottom: BorderSide(width: 1, color: Colors.black26)
          )
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(left: getMargin(level ?? 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            line(225),
            Container(padding: EdgeInsets.only(top:8)),
            line(100),
            Container(padding: EdgeInsets.only(top:8)),
            line(200),
            Container(padding: EdgeInsets.only(top:8)),
            line(150),
            Container(padding: EdgeInsets.only(top:8)),
            line(50),
          ],
        )
      );
  }

  Widget line(int width) {
    return Row(children: <Widget>[
        Container(height: 15, width: width.toDouble(), color: Colors.black12)
      ]
    );
  }

  double getMargin(int level) {
    final double base = 4.0;
    if (level == 1) return 0.0;
    if (level == 2) return base;
    if (level == 3) return base*2;
    if (level == 5) return base*3;
    if (level == 6) return base*4;
    else return base*5;
  }

  Color getColor(int level) {
    if (level%3 == 1) return Colors.redAccent;
    if (level%3 == 2) return Colors.cyan;
    if (level%3 == 0) return Colors.amber;
  }
}