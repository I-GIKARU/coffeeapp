import 'package:flutter/material.dart';
const textInputDecoration = InputDecoration(
labelText: 'Email',
labelStyle: TextStyle(color: Colors.black),
fillColor: Colors.white,
filled: true,
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.black, width: 2.0),
),
focusedBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.green, width: 2.0),
)
);