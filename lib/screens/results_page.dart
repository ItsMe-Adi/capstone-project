import 'dart:ui';

import 'package:capstoneapp/components/bottom_button.dart';
import 'package:capstoneapp/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:capstoneapp/constants.dart';

class ResultPage extends StatelessWidget {
  static const String id = 'result_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAPTION GENERATOR'),
        backgroundColor: Color(0xFF0A0E21),
      ),
      backgroundColor: Color(0xFF0A0E21),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Your Result',
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    caption,
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'GENERATE NEW CAPTION',
            onTap: () {
              caption = null;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
