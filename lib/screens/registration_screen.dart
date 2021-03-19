import 'package:firebase_flutter_chat/constants.dart';
import 'package:firebase_flutter_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter_chat/components/ic_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showSpinner = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email',
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email cannot be empty';
                        }

                        if (!EmailValidator.validate(value.trim())) {
                          return 'Invalid email. Please enter another one';
                        }

                        return null;
                      },
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password',
                      ),
                      textAlign: TextAlign.center,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password cannot be empty';
                        }

                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }

                        return null;
                      },
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    ICButton(
                      color: Colors.blueAccent,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            setState(() {
                              showSpinner = true;
                            });

                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                              email: email.trim(),
                              password: password,
                            );

                            if (newUser != null) {
                              Navigator.pushNamed(context, LoginScreen.id);
                            }
                          } catch (e) {
                            if (e.code == 'email-already-in-use') {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Registration'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            Text('$email is already used.'),
                                            Text('Please use a different one.'),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Ok',
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          } finally {
                            _emailController.clear();
                            _passwordController.clear();

                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      },
                      title: 'Register',
                    ),
                  ],
                ),
              ),
            ),
          ),
          inAsyncCall: showSpinner,
        ),
      ),
    );
  }
}
