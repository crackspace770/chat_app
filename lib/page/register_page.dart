import 'package:chat_app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/register_button.dart';

class RegisterPage extends StatefulWidget {

  final VoidCallback showLoginPage;

  const RegisterPage({super.key,
    required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();


  Future signUp() async {
    if (passwordIsConfirmed()) {
      try {
        // Create user
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Get UID of the newly created user
        String uid = userCredential.user!.uid;

        // Add user to Firestore
        await addUsers(
          uid,
          usernameController.text.trim(),
          emailController.text.trim(),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
  }

  Future<void> addUsers(String uid, String username, String email,) async {
    await FirebaseFirestore.instance.collection('user').doc(uid).set({
      'uid': uid,
      'username': username,
      'email' : email
    });
  }




  bool passwordIsConfirmed() {
    if(passwordController.text.trim() == confirmedPasswordController.text.trim() ) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(Icons.chat_rounded,
              size: 30,
              ),
              SizedBox(height: 10),
              Text("Please register your account!",
                style: TextStyle(
                  fontSize: 18,

                ),
              ),
              SizedBox(height: 25),

              //username textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          hintText: 'Username',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextField(
                      controller: confirmedPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: RegisterButton(
                    textButton: 'Register',
                    onTap: ()=> signUp(),
                  )
              ),

              SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text("Sign In Now!",
                        style: TextStyle(
                            color: Colors.blue
                        ),
                      ),
                    )

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }
}