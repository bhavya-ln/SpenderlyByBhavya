import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spenderly/pages/men.dart';
import 'package:spenderly/pages/women.dart';
import 'package:spenderly/pages/jewellery.dart';
import 'package:spenderly/pages/electronics.dart';
import 'package:spenderly/pages/splash_screen.dart';
import 'package:spenderly/pages/login.dart';
import 'package:spenderly/provider/google_sign_in.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'dashboard.dart';
import 'fav.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  Text(
                    'Spenderly',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Engagement'),
                  )
                ]),
            decoration: BoxDecoration(color: Color(0xff7beed9)),
          ),
          ListTile(
            title: Text('Dashboard'),
            leading: Icon(Icons.dashboard_outlined, color: Colors.black),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
          ListTile(
            title: Text('Favourites'),
            leading: Icon(
              Icons.favorite_outline_rounded,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fav()));
            },
          ),
          ListTile(
            title: Text("Women's Clothing"),
            leading: Icon(Ionicons.female_sharp, color: Colors.black),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WomenClothes()));
            },
          ),
          ListTile(
            title: Text("Men's Clothing"),
            leading: Icon(
              Ionicons.male_sharp,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenClothes()));
            },
          ),
          ListTile(
            title: Text('Jewellery'),
            leading: Icon(Icons.auto_awesome_sharp, color: Colors.black),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => jewel()));
            },
          ),
          ListTile(
            title: Text('Electronics'),
            leading:
                Icon(Icons.devices_other_sharp, color: Colors.black),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => electronics()));
            },
          ),
          ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout, color: Colors.black),
              onTap: () {
                FirebaseAuth.instance.signOut();
                //choice is the variable that is obtained from the sign_up page
                if (choice == 1) {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.Logout();
                }
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => splash()));
              })
        ],
      ),
    );
  }
}
