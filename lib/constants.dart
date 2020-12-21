import 'package:flutter/material.dart';

String caption;

final kRoundedButtonTextStyle = TextStyle(
  color: Color(0xFF1CEDCE),
  letterSpacing: 1.5,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kWelcomeScreenTextStyle = TextStyle(
  color: Colors.white,
  letterSpacing: 1.5,
  fontSize: 60.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSana',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.green,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);
