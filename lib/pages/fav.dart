import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:spenderly/pages/cart.dart';
import 'package:spenderly/pages/nav_bar.dart';

final user = FirebaseAuth.instance.currentUser!;
CollectionReference user_collection =
    FirebaseFirestore.instance.collection('Users');

var UID = user.uid;
double i = 0;

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  final Stream<QuerySnapshot> _Favs = FirebaseFirestore.instance
      .collection('Users')
      .doc(UID)
      .collection('Favourites')
      .snapshots();

  @override
  void initState() {
    super.initState();
    var uid = FirebaseAuth.instance.currentUser!.uid;
    i = 0;

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Favourites')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          i = i + 1;
        });
      });
    });
  }

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
                      Navigator.of(context).pushAndRemoveUntil(
                          
                          MaterialPageRoute(
                              builder: (context) => ShoppingCart()),
                               (Route<dynamic> route) => false);
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Color(0xffd4fff7),
                    ))
              ],
              flexibleSpace: new FlexibleSpaceBar(
                  title: Text(
                    "Favorites",
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
                        image: AssetImage("assets/fav.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            ),
          ];
        },
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: _Favs,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

            if(i!=0)
              {
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
                                                    Center(
                                                      child: Container(
                                                        height: height * 0.025,
                                                        width: width * 0.30,
                                                        child: Text(
                                                          '\$ ' +
                                                              data['Price']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'STIXTwoText',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                                var docId =
                                                                    document.id;
                                                                print(docId);
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Users')
                                                                    .doc(UID)
                                                                    .collection(
                                                                        'Favourites')
                                                                    .doc(docId)
                                                                    .delete();
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Removed from Favourites",
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
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_forever,
                                                                color:
                                                                    Colors.red,
                                                              )),
                                                          SizedBox(
                                                            width:
                                                                width * 0.001,
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                user_collection
                                                                    .doc(UID)
                                                                    .collection(
                                                                        'Cart')
                                                                    .doc(data[
                                                                        'Id'])
                                                                    .set({
                                                                  'Category': data[
                                                                      'Category'],
                                                                  'Price': data[
                                                                      'Price'],
                                                                  'Title': data[
                                                                      'Title'],
                                                                  'Image': data[
                                                                      'Image'],
                                                                });
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Added To Cart",
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
                                                                var docId =
                                                                    document.id;
                                                                print(docId);
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Users')
                                                                    .doc(UID)
                                                                    .collection(
                                                                        'Favourites')
                                                                    .doc(docId)
                                                                    .delete();
                                                              },
                                                              icon: Icon(Icons
                                                                  .add_shopping_cart_sharp))
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
    );
  }
}
