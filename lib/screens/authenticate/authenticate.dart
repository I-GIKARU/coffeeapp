import 'package:coffee/screens/authenticate/register.dart';
import 'package:coffee/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    if (showSignIn) {
      return  Signin(
        toggleView: toggleView

      );
    } else {
      return  Register(
        toggleView: toggleView
      );
    }
  }
}
