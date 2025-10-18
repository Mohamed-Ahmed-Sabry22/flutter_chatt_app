import 'package:_8_chat_app/firebase_options.dart';
import 'package:_8_chat_app/screens/chathome.dart';
import 'package:_8_chat_app/screens/login.dart';
import 'package:_8_chat_app/screens/sign_up.dart';
import 'package:_8_chat_app/screens/splach.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'poppins'),
      title: 'scholar App',
      home: Splach(),
      routes: {
        "splach": (context) => Splach(),
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        ChatHome.id: (context) => ChatHome(),
      },
    );
  }
}
