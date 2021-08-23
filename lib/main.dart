import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:spenderly/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spenderly/pages/user_check.dart';
import 'package:spenderly/provider/google_sign_in.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Spenderly',
                home: User_Check(),
              ),
    );
  
}


