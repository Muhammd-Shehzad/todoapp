import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/Custom_widget/custom_button.dart';
import 'package:todoapp/UI/Login/login_Screen.dart';
import 'package:todoapp/Utils/toast_poppup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.pink, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up Your Account',
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Enter Your Email');
                  }
                  return null;
                },
                controller: emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Passwoed';
                  }
                },
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            isLoading
                ? CircularProgressIndicator()
                : CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          ToastPoppup().toast(
                              'Account Created', Colors.green, Colors.white);
                          setState(() {
                            isLoading = true;
                          });
                        } else {
                          ToastPoppup().toast('Account not Created',
                              Colors.green, Colors.white);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    text: 'Sing Up',
                    color: [
                      Colors.pink.withOpacity(.9),
                      Colors.pinkAccent.withOpacity(.6)
                    ],
                    height: 50.h,
                    weight: 330.w,
                  ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do You Have Account?',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Sing In',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
