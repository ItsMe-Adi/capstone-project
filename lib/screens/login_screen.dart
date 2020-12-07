import 'package:capstoneapp/constants.dart';
import 'package:capstoneapp/screens/functionality_screen.dart';
import 'package:capstoneapp/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstoneapp/components/alert_box.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  // bool _rememberMe = false;
  String password;
  String email;
  bool showSpinner = false;

  //Social button
  /*
  Widget _SocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              )
            ],
            image: DecorationImage(
              image: logo,
            )),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/nature1.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Sign in text
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        //Email box
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Email',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 60.0,
                              child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your Email',
                                  hintStyle: kHintTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        //Password Box
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Password',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 60.0,
                              child: TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your Password',
                                  hintStyle: kHintTextStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                        //Forgot password button
                        /*
                        Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () =>
                                print('Forgot Password Button Pressed'),
                            padding: EdgeInsets.only(right: 0.0),
                            child: Text(
                              'Forgot Password?',
                              style: kLabelStyle,
                            ),
                          ),
                        ),
                         */
                        //Check me box
                        /*
                        Container(
                          height: 20.0,
                          child: Row(
                            children: <Widget>[
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                                child: Checkbox(
                                  value: _rememberMe,
                                  checkColor: Colors.green,
                                  activeColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                'Remember Me',
                                style: kLabelStyle,
                              )
                            ],
                          ),
                        ),
                         */
                        //Login button
                        SizedBox(height: 70),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () async {
                              if (email == null || password == null) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertBox(
                                      'Empty', 'Some field is left empty'),
                                  barrierDismissible: false,
                                );
                              } else {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: password);
                                  if (user != null) {
                                    Navigator.pushNamed(
                                        context, FunctionalityScreen.id);
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertBox(
                                        'Check Credentials',
                                        'Email or Password is incorrect'),
                                    barrierDismissible: false,
                                  );
                                }
                              }
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.green,
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                        //OR sign in with text
                        /*
                        Column(
                          children: <Widget>[
                            Text(
                              'OR',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Sign in with',
                              style: kLabelStyle,
                            ),
                          ],
                        ),
                         */
                        //Social Buttons
                        /*
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _SocialBtn(
                                () => print('Login with Facebook'),
                                AssetImage('assets/images/facebook.jpg'),
                              ),
                              _SocialBtn(
                                () => print('Login with Google'),
                                AssetImage('assets/images/google.jpg'),
                              ),
                            ],
                          ),
                        ),
                         */
                        //Sign up Button
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RegistrationScreen.id),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Don't have an Account? ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
