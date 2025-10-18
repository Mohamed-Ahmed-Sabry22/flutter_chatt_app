import 'package:_8_chat_app/screens/chathome.dart';
import 'package:_8_chat_app/screens/login.dart';
import 'package:_8_chat_app/widgets/custom_TextFormFeild.dart';
import 'package:_8_chat_app/widgets/custom_buttton.dart';
import 'package:_8_chat_app/widgets/upphoto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  SignUp({super.key});
  static String id = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;

  String? password;

  String? pass;

  GlobalKey<FormState> formKey = GlobalKey();
  bool isloading = false;
  bool obsecure = false;
  bool obsecure2 = false;
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
                        'Get Started Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      Customtextformfeild(
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'it is required';
                          }
                          return null;
                        },
                        hintText: 'Enter your name',
                        labelText: 'Name',
                      ),
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
                          pass = value;
                          if (value == null || value.isEmpty) {
                            return 'it is required';
                          } else if (value.length < 8) {
                            return 'password must be more than 8 letters';
                          }
                          return null;
                        },
                        hintText: "Enter your password",
                        labelText: "Password",
                      ),
                      Customtextformfeild(
                        obscureText: !obsecure2,
                        suffixWidget: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecure2 = !obsecure2;
                            });
                          },
                          icon: Icon(
                            obsecure2 ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                          ),
                        ),
                        onChanged: (data) {
                          password = data;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'it is required';
                          } else if (value != pass) {
                            return 'password doesn\'t match';
                          }
                          return null;
                        },
                        hintText: "Password",
                        labelText: "Confirm your password",
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await registerUser();
                              successDialog(context);
                            } on FirebaseAuthException catch (e) {
                              print(e);
                              if (e.code == 'weak-password') {
                                snackBar(
                                  context,
                                  msg: "The password provided is too weak.",
                                );
                              } else if (e.code == 'email-already-in-use') {
                                snackBar(
                                  context,
                                  msg:
                                      'The account already exists for that email.',
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
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?',
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
                              ).pushReplacementNamed(Login.id);
                            },
                            child: Text(
                              'Sign In',
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

  void snackBar(BuildContext context, {required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
      ),
    );
  }

  void successDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('You created Account Successfully .'),
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

  Future<void> registerUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
