// ignore_for_file: avoid_print

import 'dart:async';

import 'package:coffee/models/user.dart' as custom;
import 'package:coffee/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:coffee/models/user.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  // Converts a Firebase User to a custom User model
  custom.User? _userFromFirebaseUser(firebase_auth.User? user) {
    return user != null ? custom.User(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<User?> get user {
    return _auth
        .authStateChanges()
        .map((firebase_auth.User? user) => _userFromFirebaseUser(user));
  }



  // Signs in a user anonymously
  Future<custom.User?> signInAnon() async {
    try {
      firebase_auth.UserCredential result = await _auth.signInAnonymously();
      firebase_auth.User? user = result.user;
      if (user != null) {
        custom.User? customUser = _userFromFirebaseUser(user);
       print("Signed in anonymously: }"); // Print only the UID
        return customUser;
      } else {
        print("Anonymous user sign-in failed: User is null");
        return null;
      }
    } catch (e) {
      // Log the error
      print("Error during anonymous sign-in: ${e.toString()}");
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      firebase_auth.UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      firebase_auth.User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      firebase_auth.UserCredential result = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      firebase_auth.User? user = result.user;


      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}