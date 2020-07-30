import 'package:capstoneapp/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstoneapp/components/reusable_card.dart';
import 'package:capstoneapp/components/icon_content.dart';
import 'package:capstoneapp/components/bottom_button.dart';

class FunctionalityScreen extends StatefulWidget {
  static const String id = 'functionality_screen';
  @override
  _FunctionalityScreenState createState() => _FunctionalityScreenState();
}

class _FunctionalityScreenState extends State<FunctionalityScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAPTION GENERATOR'),
        backgroundColor: Color(0xFF0A0E21),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      backgroundColor: Color(0xFF0A0E21),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {},
                    cardChild: IconContent(
                        label: 'CAMERA', icon: FontAwesomeIcons.camera),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {},
                    cardChild: IconContent(
                        label: 'VIDEO', icon: FontAwesomeIcons.video),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              onPress: () {},
              cardChild: IconContent(
                  label: 'UPLOAD FROM GALLERY', icon: FontAwesomeIcons.upload),
            ),
          ),
          BottomButton(
            buttonTitle: 'GET CAPTION',
            onTap: () {
              Navigator.pushNamed(context, ResultPage.id);
            },
          ),
        ],
      ),
    );
  }
}
