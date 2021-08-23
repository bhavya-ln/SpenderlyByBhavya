import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spenderly/pages/dashboard.dart';
import 'package:spenderly/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spenderly/pages/user_check.dart';
import 'package:spenderly/provider/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

FirebaseAuth auth = FirebaseAuth.instance;
var name, email_id, UID, photo;
int choice = 0;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {}
    });
    Widget _textInput({hint, icon, myController, obscure}) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: myController,
          decoration: InputDecoration(
            border: new UnderlineInputBorder(
              borderSide: new BorderSide(),
            ),
            hintText: hint,
            prefixIcon: Icon(icon),
          ),
          obscureText: obscure,
        ),
      );
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffd4fff7),
      //To extend the size of the app bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.4),
        child: AppBar(
          backgroundColor: Color(0xff7beed9),
          centerTitle: true,
          flexibleSpace: Container(
            height: height * 0.4,
            width: width,
            color: Color(0xff7beed9),
            child: Center(
              child: Hero(
                tag: 'Sign In',
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.09,
                      ),
                      Text(
                        "Spenderly",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Engagement',
                          color: Color(0xff171f28),
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: "STIXTwoText",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30, //border color
                          child: Padding(
                            padding: const EdgeInsets.all(2.0), //border size
                            child: CircleAvatar(
                              radius: 27,
                              backgroundImage: AssetImage("assets/logo.png"),
                              backgroundColor: Color(0xff7beed9),
                            ),
                          )),
                      SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Color(0xffd4fff7),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    _textInput(
                        hint: "Email",
                        icon: Icons.email,
                        myController: email,
                        obscure: false),
                    _textInput(
                      hint: "Password",
                      icon: Icons.lock,
                      myController: password,
                      obscure: true,
                    ),
                    SizedBox(height: height * 0.05),
                    ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          Fluttertoast.showToast(
                              msg: "Signed In!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xff7beed9),
                              textColor: Colors.black,
                              fontSize: 16.0);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            Fluttertoast.showToast(
                                msg: "No user found for that email.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xff7beed9),
                                textColor: Colors.black,
                                fontSize: 16.0);
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            Fluttertoast.showToast(
                                msg: "Wrong password provided for that user.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xff7beed9),
                                textColor: Colors.black,
                                fontSize: 16.0);
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                      icon: Icon(Icons.next_plan, color: Color(0xffd4fff7)),
                      label: Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily: 'STIXTwoText',
                          color: Color(0xffd4fff7),
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff171f28),
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    Text(
                      "Dont have an Account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'STIXTwoText'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'STIXTwoText',
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Divider(
                      color: Color(0xff171f28),
                      thickness: 0.25,
                    ),
                    // SizedBox(height: height * 0.05),
                    Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'STIXTwoText',
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          choice = 1;
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                          final user = FirebaseAuth.instance.currentUser!;
                          UID = user.uid;
                          name = user.displayName;
                          email_id = user.email;
                          photo = user.photoURL.toString();
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(UID)
                              .set({
                            'Email': email_id,
                            'Name': name,
                            'Photo': photo
                          });
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => User_Check()));
                        } on FirebaseAuthException catch (e) {
                          Fluttertoast.showToast(
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xff7beed9),
                              textColor: Colors.black,
                              fontSize: 16.0);
                          print(e.toString());
                        }
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Color(0xffd4fff7),
                      ),
                      label: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontFamily: 'STIXTwoText',
                          color: Color(0xffd4fff7),
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff171f28),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
