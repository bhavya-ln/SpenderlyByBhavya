import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spenderly/pages/cart.dart';
import 'package:spenderly/pages/nav_bar.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';



CollectionReference user_collection = FirebaseFirestore.instance.collection('Users');

List jewelery = [];
Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class jewel extends StatefulWidget {
  @override
  _jewelState createState() => _jewelState();
}

class _jewelState extends State<jewel> {
  void getProduct() async {
    Response response =
        await get(Uri.parse('https://fakestoreapi.com/products'));
    List data = jsonDecode(response.body);
    for (int i = 4; i <= 7; i++) {
      jewelery.add(data[i]);
    }

    print(jewelery);
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: wait(3),
        builder: (context, snapshot) {
          if (jewelery.length.toString() != '0') {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xffd4fff7),
                drawer: NavBar(),
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShoppingCart()));
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Color(0xffd4fff7),
                              ))
                        ],
                        flexibleSpace: new FlexibleSpaceBar(
                            title: Text(
                              "Jewellery",
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
                                  image: AssetImage("assets/jewel.jpg"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )),
                      ),
                    ];
                  },
                  body: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: EdgeInsets.all(height * 0.009),
                          child: Card(
                            elevation: height * 0.005,
                            child: Container(
                                height: height * 0.35,
                                width: width * 0.87,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.3,
                                          width: width * 0.4,
                                          decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: NetworkImage(
                                                  jewelery[index]["image"]),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.05,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: height * 0.1,
                                            width: width * 0.30,
                                            child: Text(
                                              jewelery[index]["title"],
                                              style: TextStyle(
                                                  fontFamily: 'STIXTwoText',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: height * 0.025,
                                          // ),
                                          Center(
                                            child: Container(
                                              height: height * 0.025,
                                              width: width * 0.30,
                                              child: Text(
                                                '\$ ' +
                                                    jewelery[index]["price"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'STIXTwoText',
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.05,
                                          ),
                                          Center(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                    int id= jewelery[index]["id"];
                                                    final user = FirebaseAuth.instance.currentUser!;
                                                    var UID = user.uid;
                                                     user_collection
                                                    .doc(UID).collection('Cart').
                                                    doc(id.toString())
                                                    .set({
                                                      'Category':jewelery[index]["category"],
                                                      'Price':jewelery[index]["price"],
                                                      'Title': jewelery[index]["title"],
                                                      'Image': jewelery[index]["image"],        
                                                      });
                                                    Fluttertoast.showToast(
                                                    msg: "Added To Cart",
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Color(0xff7beed9),
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);



                                                    },
                                                    icon: Icon(
                                                      Icons.add_shopping_cart,
                                                      color: Colors.black,
                                                    )),
                                                SizedBox(
                                                  width: width * 0.001,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      int id= jewelery[index]["id"];
                                                    final user = FirebaseAuth.instance.currentUser!;
                                                    var UID = user.uid;
                                                     user_collection
                                                    .doc(UID).collection('Favourites').
                                                    doc(id.toString())
                                                    .set({
                                                      'Category':jewelery[index]["category"],
                                                      'Price':jewelery[index]["price"],
                                                      'Title': jewelery[index]["title"],
                                                      'Image': jewelery[index]["image"],        
                                                      });
                                                      Fluttertoast.showToast(
                                                    msg: "Added To Favourites",
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Color(0xff7beed9),
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .favorite_outline_sharp,
                                                      color: Colors.black,
                                                    )),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.next_plan,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
                ),
              ),
            );
          }
          return Scaffold(body: Center(child: Lottie.asset('assets/lottie/57996-mas-jewellery.json')));
        });
  }
}
