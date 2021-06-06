import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowers_commerce/constant.dart';
import 'package:flowers_commerce/screens/home/home_page.dart';
import 'package:flowers_commerce/screens/login/login_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _initialization, builder: _builder);
  }

  Widget _builder(BuildContext context, AsyncSnapshot snapshot) {
    //Firebase init with error
    if (snapshot.hasError) {
      return Scaffold(
        body: Center(
          child: Text(
            "Error: ${snapshot.error}",
            style: Constant.regularHeadingStyle,
          ),
        ),
      );
    }

    //Firebase init successed
    if (snapshot.connectionState == ConnectionState.done) {
      return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: _checkLoginBuilder,
      );
    }

    // Loading
    return Scaffold(
      body: Center(
        child: Text(
          "Firebase App .......",
          style: Constant.regularHeadingStyle,
        ),
      ),
    );
  }

  Widget _checkLoginBuilder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Scaffold(
        body: Center(
          child: Text(
            "Error: ${snapshot.error}",
            style: Constant.regularHeadingStyle,
          ),
        ),
      );
    }

    if (snapshot.connectionState == ConnectionState.active) {
      User _user = snapshot.data;
      if (_user == null) {
        return LoginPage();
      } else {
        return HomePage();
      }
    }

    return Scaffold(
      body: Center(
        child: Text(
          "Firebase loading authentication",
          style: Constant.regularHeadingStyle,
        ),
      ),
    );
  }
}
