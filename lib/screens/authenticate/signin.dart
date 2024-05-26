// ignore_for_file: unused_field, avoid_print, use_super_parameters, library_private_types_in_public_api

import 'package:coffee/services/auth.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class Signin extends StatefulWidget {
  final Function toggleView;
  const Signin({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<Signin> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: const Text('Sign In to coffee'),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Register'),
              onPressed: () {
                widget.toggleView();
              },
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  decoration: textInputDecoration.copyWith(labelText: 'Email'),
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) =>
                      val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  decoration: textInputDecoration.copyWith(labelText: 'Password'),
                  style: const TextStyle(color: Colors.black),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  child: const Text('Sign In'),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(
                         email, password);
                     if (result == null) {
                       setState((){
                        error = 'Could not sign in with those credentials';
                       loading = false;
                       });
                     }
                    }
                  },
                ),
                const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ));
  }
}
