import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:capstoneapp/constants.dart';
import 'package:capstoneapp/screens/login_screen.dart';
import 'package:capstoneapp/screens/registration_screen.dart';
import 'package:capstoneapp/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //gradient theme
          /*
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple[200],
                  Colors.deepPurple[400],
                  Colors.deepPurple[600],
                  Colors.deepPurple[800],
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          */

          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/galaxy.jpg'),
                  fit: BoxFit.cover),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 70.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    //width: 350.0,
                    child: TextLiquidFill(
                      text: '    Digital\n    Media\nCaptioning',
                      waveColor: Color(0xFF1CEDCE),
                      waveDuration: Duration(seconds: 6),
                      boxBackgroundColor: Color(0xFF0A0C12),
                      textStyle: kWelcomeScreenTextStyle,
                      boxHeight: 300.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 125.0),
              RoundedButton(
                title: 'LOGIN',
                color: Color(0xFF0A0C12),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              RoundedButton(
                title: 'REGISTER',
                color: Color(0xFF0A0C12),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
