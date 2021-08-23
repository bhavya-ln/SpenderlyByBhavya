// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:spenderly/pages/men.dart';
import 'package:spenderly/pages/women.dart';
import 'package:spenderly/pages/jewellery.dart';
import 'package:spenderly/pages/nav_bar.dart';
import 'package:spenderly/pages/electronics.dart';
// import 'package:spenderly/pages/splash_screen.dart';
// import 'package:spenderly/provider/google_sign_in.dart';


import 'cart.dart';
import 'fav.dart';

//var choice=1;//get from user database, as the choice they select while signing in 

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffd4fff7),
      drawer: NavBar(),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Color(0xff7beed9),
                pinned: true,
                snap: true,
                floating: true,
                expandedHeight: height * 0.4,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Fav()));
                      },
                      icon: Icon(
                        Icons.favorite_outline_rounded,
                        color: Color(0xffd4fff7),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShoppingCart()));
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Color(0xffd4fff7),
                      )),
                ],
                flexibleSpace: new FlexibleSpaceBar(
                    title: Text(
                      "Dashboard",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Engagement',
                        color: Color(0xffd4fff7),
                        fontSize: 40,
                      ),
                    ),
                    centerTitle: true,
                    background: Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: AssetImage("assets/dasboard.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: "STIXTwoText",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                                height: height * 0.26,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: AssetImage("assets/wom.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: height * 0.17),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WomenClothes()));
                                      },
                                      icon: Icon(Icons.next_plan,
                                          color: Color(0xffd4fff7)),
                                      label: Text(
                                        "Women's \nClothing",
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
                                  ],
                                ))),
                        SizedBox(
                          width: width * 0.072,
                        ),
                        Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                                height: height * 0.26,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: AssetImage("assets/man.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: height * 0.17),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MenClothes()));
                                      },
                                      icon: Icon(Icons.next_plan,
                                          color: Color(0xffd4fff7)),
                                      label: Text(
                                        "Men's \nClothing",
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
                                  ],
                                )))
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                                height: height * 0.26,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: AssetImage("assets/jewel.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: height * 0.17),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => jewel()));
                                      },
                                      icon: Icon(Icons.next_plan,
                                          color: Color(0xffd4fff7)),
                                      label: Text(
                                        "Jewellery",
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
                                  ],
                                ))),
                        SizedBox(
                          width: width * 0.072,
                        ),
                        Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                                height: height * 0.26,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: AssetImage("assets/elec.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: height * 0.17),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => electronics()));
                                      },
                                      icon: Icon(Icons.next_plan,
                                          color: Color(0xffd4fff7)),
                                      label: Text(
                                        "Electronics",
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
                                  ],
                                )))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
