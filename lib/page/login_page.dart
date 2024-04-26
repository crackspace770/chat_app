import 'package:chat_app/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async{
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        } );

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    );

    Navigator.of(context).pop();
  }

  Future login() async {
    //auth service
    final authService = AuthService();

    //try login
    try{
      await authService.signInWithEmailPassword(emailController.text.trim(), passwordController.text.trim());
    }
    
    //catch any error
    catch(e) {
      showDialog
        (context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()
            ),
          )
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person,
                size: 50,
                ),

                const Text("ChatApp",
                style:TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
                ),

                const SizedBox(height: 10),

                const Text("Please login to your account",
                style: TextStyle(
                  fontSize: 18,
                ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none
                        ),

                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none,

                        ),

                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: login,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                            child: Text("Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                            ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text("Not a member?"),
                    const SizedBox(width: 5),

                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: const Text('Register now!',
                      style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
