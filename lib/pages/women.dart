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
List women = [];
Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class WomenClothes extends StatefulWidget {
  @override
  _WomenClothesState createState() => _WomenClothesState();
}

class _WomenClothesState extends State<WomenClothes> {
  void getProduct() async {
    Response response =
        await get(Uri.parse('https://fakestoreapi.com/products'));
    List data = jsonDecode(response.body);
    for (int i = 14; i <= 19; i++) {
      women.add(data[i]);
    }

    print(women);
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
          if (women.length != 0) {
            return Scaffold(
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
                            )),
                      ],
                      flexibleSpace: new FlexibleSpaceBar(
                          title: Text(
                            "Women's Clothing",
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
                                image: AssetImage("assets/wom.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ),
                  ];
                },
                body: ListView.builder(
                    itemCount: 6,
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
                                        width: width * 0.41,
                                        decoration: BoxDecoration(
                                          image: new DecorationImage(
                                            image: NetworkImage(
                                                women[index]["image"]),
                                            fit: BoxFit.cover,
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
                                            women[index]["title"],
                                            style: TextStyle(
                                                fontFamily: 'STIXTwoText',
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.025,
                                        ),
                                        Center(
                                          child: Container(
                                            height: height * 0.025,
                                            width: width * 0.30,
                                            child: Text(
                                              '\$ ' +
                                                  women[index]["price"]
                                                      .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'STIXTwoText',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
                                                    int id= women[index]["id"];
                                                    final user = FirebaseAuth.instance.currentUser!;
                                                    var UID = user.uid;
                                                     user_collection
                                                    .doc(UID).collection('Cart').
                                                    doc(id.toString())
                                                    .set({
                                                      'Category':women[index]["category"],
                                                      'Price':women[index]["price"],
                                                      'Title': women[index]["title"], 
                                                      'Image': women[index]["image"],       
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
                                                  onPressed: () {int id= women[index]["id"];
                                                    final user = FirebaseAuth.instance.currentUser!;
                                                    var UID = user.uid;
                                                     user_collection
                                                    .doc(UID).collection('Favourites').
                                                    doc(id.toString())
                                                    .set({
                                                      'Category':women[index]["category"],
                                                      'Price':women[index]["price"],
                                                      'Title': women[index]["title"],
                                                      'Image': women[index]["image"],        
                                                      });
                                                      Fluttertoast.showToast(
                                                    msg: "Added To Favourites",
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Color(0xff7beed9),
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);},
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
            );
          }
          return Scaffold(body: Center(child: Lottie.asset('assets/lottie/33218-shopping.json')));
        });
  }
}
