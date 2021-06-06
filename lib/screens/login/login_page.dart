import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowers_commerce/component/custom_button.dart';
import 'package:flowers_commerce/component/login_textfield.dart';
import 'package:flowers_commerce/constant.dart';
import 'package:flowers_commerce/screens/login/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";
  bool _isLoading = false;

  Future<String> _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitFrom() async {
    setState(() {
      _isLoading = true;
    });
    String loginResult = await _login();
    if (loginResult != null) {
      Constant.showErrorDialog(context, 'Error', loginResult);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: _screen.height * 0.07,
              bottom: _screen.height * 0.03,
              left: 24,
              right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome User,\nLogin to your account',
                style: Constant.regularHeadingStyle,
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  LoginTextField(
                    hint: 'Email...',
                    onChanged: (value) {
                      _email = value;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20),
                  LoginTextField(
                    hint: 'Password...',
                    onChanged: (value) {
                      _password = value;
                    },
                    isPassword: true,
                    onSubmitted: (value) {
                      _submitFrom();
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Login',
                    press: () {
                      _submitFrom();
                    },
                    isLoading: _isLoading,
                  )
                ],
              ),
              CustomButton(
                text: 'Create New Account',
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                isOutline: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
