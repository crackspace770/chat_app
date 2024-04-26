import 'package:chat_app/page/register_page.dart';
import 'package:flutter/material.dart';

import '../page/login_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  //initially show login page
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = ! showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreen);
    } else{
      return RegisterPage(showLoginPage: toggleScreen);
    }
  }
}


