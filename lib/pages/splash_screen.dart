import 'package:flutter/material.dart';
import 'package:spenderly/pages/login.dart';

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Login(),
    transitionDuration: Duration(milliseconds: 550),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);

      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      const curve = Curves.easeOut;
      final offsetAnimation = animation.drive(tween);

      final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: height * 0.7,
              width: width,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image: AssetImage("assets/main_screen.jpg"),
                fit: BoxFit.cover,
              )),
            ),
          ),
          Positioned(
            top: height * 0.60,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: height * 0.45,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.zero,
                    topLeft: Radius.circular(40.0),
                    bottomLeft: Radius.zero),
                color: Color(0xff7beed9),
              ),
              child: Hero(
            
                tag: 'Sign In',
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          height: height * 0.09,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Spenderly",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Engagement',
                              color: Color(0xff171f28),
                              fontSize: 40,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
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
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        SizedBox(
                          width: width*0.824,
                          height:height*0.045,
                          child: Text(
                            "Continue to explore a new world of shopping",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'STIXTwoText',
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(_createRoute());
                            },
                            icon: Icon(
                              Icons.next_plan,
                              color: Color(0xffd4fff7),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff171f28),
                            ),
                            label: Text(
                              "Continue",
                              style: TextStyle(
                                fontFamily: 'STIXTwoText',
                                color: Color(0xffd4fff7),
                                fontSize: 15,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
