import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spenderly/pages/cart.dart';
import 'package:spenderly/pages/nav_bar.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}
