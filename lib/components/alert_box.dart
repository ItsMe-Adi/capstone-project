import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  AlertBox(this.title, this.content);
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
      elevation: 24.0,
    );
  }
}
