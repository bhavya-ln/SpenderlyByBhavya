import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spenderly/pages/dashboard.dart';
import 'package:spenderly/pages/fav.dart';
import 'package:spenderly/pages/nav_bar.dart';
import 'package:lottie/lottie.dart';

final user = FirebaseAuth.instance.currentUser!;
var UID = user.uid;
double sum = 0;

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
//Dont put this line outside the class, since outside it becomes a global variable and the values dont change and hence when you open the cart the next time it is stuck in a loading screen
  final Stream<QuerySnapshot> _Cart = FirebaseFirestore.instance
      .collection('Users')
      .doc(UID)
      .collection('Cart')
      .snapshots();
  
  @override
  void initState() {
    super.initState();
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Total')
        .doc('Total')
        .get()
        .then((DocumentSnapshot snap) {
      if (snap.exists) {
        double i = 0;

        FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .collection('Cart')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            i = i + doc['Price'];
          });
          FirebaseFirestore.instance
              .collection('Users')
              .doc(uid)
              .collection('Total')
              .doc('Total')
              .set({'Total Price': i});
        });

        setState(() {
          sum = snap['Total Price'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    double i = 0;

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Cart')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        i = i + doc['Price'];
      });
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Total')
          .doc('Total')
          .set({'Total Price': i});
    });
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Fav()),
                           (Route<dynamic> route) => false);
                    },
                    icon: Icon(
                      Icons.favorite_outline_rounded,
                      color: Color(0xffd4fff7),
                    ))
              ],
              flexibleSpace: new FlexibleSpaceBar(
                  title: Text(
                    "Shopping Cart",
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
                        image: AssetImage("assets/cart.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            ),
          ];
        },
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: _Cart,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              if (sum != 0) {
                return new ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Container(
                        height: height * 0.40,
                        padding: EdgeInsets.fromLTRB(width * 0.01,
                            height * 0.01, width * 0.01, height * 0.01),
                        child: Container(
                            child: new Card(
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                ),
                                child: InkWell(
                                    child: Padding(
                                        padding: EdgeInsets.all(width * 0.04),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(height * 0.009),
                                          child: Card(
                                            elevation: height * 0.005,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height: height * 0.3,
                                                    width: width * 0.4,
                                                    decoration: BoxDecoration(
                                                      image:
                                                          new DecorationImage(
                                                        image: NetworkImage(
                                                            data['Image']
                                                                .toString()),
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
                                                        data['Title']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'STIXTwoText',
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                    // SizedBox(
                                                    //   height: height * 0.025,
                                                    // ),
                                                    Container(
                                                      height: height * 0.025,
                                                      width: width * 0.30,
                                                      child: Text(
                                                        '\$ ' +
                                                            data['Price']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'STIXTwoText',
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                                var docId =
                                                                    document.id;
                                                                print(docId);
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Users')
                                                                    .doc(UID)
                                                                    .collection(
                                                                        'Cart')
                                                                    .doc(docId)
                                                                    .delete();
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Removed from cart",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_LONG,
                                                                    gravity: ToastGravity
                                                                        .BOTTOM,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xff7beed9),
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    fontSize:
                                                                        16.0);
                                                                Navigator.of(context).pushAndRemoveUntil(
                                                                    
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ShoppingCart()),
                                                                                 (Route<dynamic> route) => false);
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_forever,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                          SizedBox(
                                                            width:
                                                                width * 0.001,
                                                          ),
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                Icons.next_plan,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))))));
                  }).toList(),
                );
              }
              return Container(child: Lottie.asset('assets/lottie/4496-empty-cart.json') ,);
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: height * 0.1,
          width: width,
          color: Color(0xff7beed9),
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.1,
                ),
                Center(
                  child: Container(
                      child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Place Order',
                          style: TextStyle(
                              fontFamily: 'Engagement',
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Total Cost: \$ ' + sum.toStringAsFixed(2),
                        style: TextStyle(
                            fontFamily: 'STIXTwoText',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  width: width * 0.1,
                ),
                ElevatedButton.icon(
                    onPressed: () async{
                      var collection = FirebaseFirestore.instance
                      .collection('Users')
                      .doc(uid)
                      .collection('Cart');
                  var snapshots = await collection.get();
                  for (var doc in snapshots.docs) {
                    await doc.reference.delete();
                  }

                  setState(() {
                    sum = 0;
                  });
                  Fluttertoast.showToast(
                                                    msg: "Order confirmed",
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Color(0xff7beed9),
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);
                    Navigator.of(context).pushAndRemoveUntil(
                                 
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()),
                                       (Route<dynamic> route) => false);                                
                    },
                    icon: Icon(Icons.payment_sharp, color: Color(0xffd4fff7)),
                    label: Text(
                      "Payment",
                      style: TextStyle(
                        fontFamily: 'STIXTwoText',
                        color: Color(0xffd4fff7),
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff171f28),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
