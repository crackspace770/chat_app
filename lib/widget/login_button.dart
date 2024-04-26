
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {

  final Function()? onTap;
  final String textButton;

  const LoginButton({super.key,
    this.onTap,
    required this.textButton});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color:  Colors.blue,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Text(textButton,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                )
            ),
          )
      ),
    );

  }
}