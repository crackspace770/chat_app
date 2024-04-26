import 'package:chat_app/auth/auth_page.dart';
import 'package:chat_app/page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
         if(snapshot.hasData) {
           return HomePage();
         }else{
           return AuthPage();
         }
        },
      ),
    );
  }
}
