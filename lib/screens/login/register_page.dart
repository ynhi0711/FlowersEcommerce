import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowers_commerce/component/custom_button.dart';
import 'package:flowers_commerce/component/login_textfield.dart';
import 'package:flowers_commerce/constant.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _registerEmail = "";
  String _registerPassword = "";
  bool _isLoading = false;

  Future<String> _createAcount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
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
    String submitResponse = await _createAcount();
    if (submitResponse != null) {
      Constant.showErrorDialog(context, 'Error', submitResponse);
      setState(() {
        _isLoading = false;
      });
    } else {
      //register successful
      Navigator.of(context).pop();
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
                'Create A New Account',
                style: Constant.regularHeadingStyle,
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  LoginTextField(
                    hint: 'Email...',
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20),
                  LoginTextField(
                    hint: 'Password...',
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    isPassword: true,
                    onSubmitted: (value) {
                      _submitFrom();
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Create Account',
                    press: () {
                      _submitFrom();
                    },
                    isLoading: _isLoading,
                  )
                ],
              ),
              CustomButton(
                  text: 'Back To Login',
                  press: () {
                    Navigator.pop(context);
                  },
                  isOutline: true)
            ],
          ),
        ),
      ),
    );
  }
}
