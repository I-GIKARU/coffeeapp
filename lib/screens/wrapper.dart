// ignore_for_file: avoid_print

import 'package:coffee/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffee/models/user.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print(user);


    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }}
}