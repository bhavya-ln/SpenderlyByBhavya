import 'package:flutter/material.dart';
import 'package:spenderly/pages/dashboard.dart';
import 'package:spenderly/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spenderly/pages/splash_screen.dart';



class User_Check extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return Dashboard();
          } else if (snapshot.hasError) {
            print('Error has occured');
          } else
            return splash();
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
