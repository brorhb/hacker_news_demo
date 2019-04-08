import 'package:flutter/material.dart';

class PlaceholderTile extends StatelessWidget {
  Widget build(BuildContext context) {
    final Color shadowboxColor = Colors.black12;
    return Column(
      children: <Widget>[
        ListTile(
          title: Row(children: <Widget>[
              Container(height: 15, width: 225.0, color: shadowboxColor)
            ]
          ),
          subtitle: Row(children: <Widget>[
              Container(height: 14, width: 75.0, color: shadowboxColor)
            ]
          ),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('0')
            ],
          ),
        )
      ]
    );
  }
}