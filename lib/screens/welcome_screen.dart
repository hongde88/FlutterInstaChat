import 'package:firebase_flutter_chat/screens/login_screen.dart';
import 'package:firebase_flutter_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_flutter_chat/components/ic_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // AnimationController controller;
  // Animation animation;

  // @override
  // void initState() {
  //   super.initState();

  //   controller = AnimationController(
  //     duration: Duration(
  //       seconds: 1,
  //     ),
  //     vsync: this,
  //   );

  //   animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
  //       .animate(controller);

  //   controller.forward();

  //   controller.addListener(() {
  //     setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   controller.dispose();
  // }

  // @override
  // void deactivate() {
  //   super.deactivate();
  //   controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                // TypewriterAnimatedTextKit(
                //   text: ['InstaChat'],
                //   textStyle: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
                Text(
                  'InstaChat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ICButton(
              color: Colors.lightBlueAccent,
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
              title: 'Log In',
            ),
            ICButton(
              color: Colors.blueAccent,
              onPressed: () {
                //Go to registration screen.
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
