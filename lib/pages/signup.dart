import 'package:flutter/material.dart';
import 'package:spenderly/pages/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


TextEditingController email = new TextEditingController();
TextEditingController password = new TextEditingController();
TextEditingController conf_password = new TextEditingController();
TextEditingController name = new TextEditingController();

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffd4fff7),
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
                      "Sign Up",
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
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: height * 0.55,
              width: width,
              color: Color(0xffd4fff7),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    children: [
                      _textInput(
                          hint: "Your Name",
                          icon: Icons.person,
                          myController: name,
                          obscure: false),
                      _textInput(
                          hint: "Email",
                          icon: Icons.email,
                          myController: email,
                          obscure: false),
                      _textInput(
                          hint: "Password",
                          icon: Icons.lock,
                          myController: password,
                          obscure: true),
                      _textInput(
                          hint: "Confirm Password",
                          icon: Icons.lock,
                          myController: conf_password,
                          obscure: true),
                      SizedBox(height: height * 0.05),
                      ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            final user = FirebaseAuth.instance.currentUser!;
                            var UID = user.uid;
                            //Add the name, email to the firestore database with UID as docName
                             FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(UID)
                                  .set({
                                'Email': email.text,
                                'Password': password.text,
                                'Name': name.text,                               
                              });
                              Fluttertoast.showToast(
                                                    msg: "Signed Up!",
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
                            if (e.code == 'weak-password') {
                              Fluttertoast.showToast(
                                                    msg: "The password provided is too weak.",
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Color(0xff7beed9),
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                               Fluttertoast.showToast(
                                                    msg: "The account already exists for that email..",
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Color(0xff7beed9),
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);
                              print('The account already exists for that email.');
                            } else if (conf_password.text != password.text) {
                               Fluttertoast.showToast(
                                                    msg: "Passwords not the same.",
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Color(0xff7beed9),
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);
                              print('Passwords not the same');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        icon: Icon(Icons.next_plan, color: Color(0xffd4fff7)),
                        label: Text(
                          "Sign Up",
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
