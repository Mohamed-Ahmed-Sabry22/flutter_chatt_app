import 'package:_8_chat_app/screens/login.dart';
import 'package:_8_chat_app/screens/sign_up.dart';
import 'package:_8_chat_app/widgets/custom_buttton.dart';
import 'package:_8_chat_app/widgets/upphoto.dart';
import 'package:flutter/material.dart';

class Splach extends StatelessWidget {
  const Splach({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          SizedBox(height: 100),
          Photo(),
          SizedBox(height: 60),
          Container(
            margin: EdgeInsetsGeometry.only(right: 40, left: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome To",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Scholar Chat",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 44,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Your Chat, Your Space",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(height: 60),
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Login.id);
                  },
                  buttonWidget: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(SignUp.id);
                  },
                  buttonWidget: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
