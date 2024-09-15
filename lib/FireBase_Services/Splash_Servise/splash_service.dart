import 'package:flutter/material.dart';
import 'package:todoapp/UI/SignUp/sign_up.dart';

class SplashService {
  void isLogIn(context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignUpScreen()));
    });
  }
}
