import 'package:_8_chat_app/screens/chathome.dart';
import 'package:_8_chat_app/screens/sign_up.dart';
import 'package:_8_chat_app/widgets/custom_TextFormFeild.dart';
import 'package:_8_chat_app/widgets/custom_buttton.dart';
import 'package:_8_chat_app/widgets/upphoto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login({super.key});
  static String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isloading = false;
  bool obsecure = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              SizedBox(height: 100),
              Photo(),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsetsGeometry.only(right: 40, left: 40),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.left,
                        'Welcome back!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Enter your Credentials to access your account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 40),
                      Customtextformfeild(
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'it is required';
                          }
                          return null;
                        },
                        onChanged: (data) {
                          email = data;
                        },
                        hintText: 'Enter your email',
                        labelText: 'Email address',
                      ),
                      Customtextformfeild(
                        obscureText: !obsecure,
                        suffixWidget: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecure = !obsecure;
                            });
                          },
                          icon: Icon(
                            obsecure ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'it is required';
                          }
                          return null;
                        },
                        onChanged: (data) {
                          password = data;
                        },
                        hintText: "Enter your password",
                        labelText: "Password",
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'forget password',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 22, 45, 177),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await loginUser();
                              successDialog(context);
                            } on FirebaseAuthException catch (e) {
                              print(e.code);
                              if (e.code == 'user-not-found') {
                                snackBar(
                                  context,
                                  msg: 'no user for that email',
                                );
                              } else if (e.code == 'wrong-password' ||
                                  e.code == 'invalid-credential') {
                                snackBar(
                                  context,
                                  msg: 'Wrong email or password.',
                                );
                              } else if (e.code == 'invalid-email') {
                                snackBar(
                                  context,
                                  msg: 'The email address is badly formatted.',
                                );
                              } else {
                                snackBar(context, msg: '${e.message}');
                              }
                            } catch (e) {
                              print(e);
                            }
                            setState(() {
                              isloading = false;
                            });
                          } else {}
                        },
                        buttonWidget: isloading
                            ? SizedBox(
                                width: 25, // العرض
                                height: 25, // الارتفاع
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed(SignUp.id);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 22, 45, 177),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  Future<dynamic> successDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('You logged in Successfully .'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ChatHome.id, arguments: email);
              },
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void snackBar(BuildContext context, {required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
      ),
    );
  }
}
