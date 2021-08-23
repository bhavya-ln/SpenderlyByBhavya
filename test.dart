import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double sum = 0;

  bool check = false;

  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }

  Future<void> setup() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    double i = 0;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Cart')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      querySnapshot.docs.forEach((doc) {
        i = i + doc['Price'];
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Total')
          .doc('Total')
          .set({'Total Price': i});
    });

    await FirebaseFirestore.instance
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
          check = true;
        });
      }
    });
  }

  // Future<double> total(double i) async {
  //      var uid = FirebaseAuth.instance.currentUser!.uid;

  //      i = 0;
  //     FirebaseFirestore.instance.collection('Users').doc(uid).collection('Cart').get().then((querySnapshot){
  //       querySnapshot.docs.forEach((document) {

  //         setState(() {
  //           i = i + document.get('Name');
  //         });
  //        });
  //     });

  //     print(i);

  //     return i;

  //   }
  // @override
  // void initState() {
  //   super.initState();

  //   setup();

  //  var uid = FirebaseAuth.instance.currentUser!.uid;
  // double i = 0;

  // FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc(uid)
  //     .collection('Cart')
  //     .get()
  //     .then((QuerySnapshot querySnapshot) async {
  //   querySnapshot.docs.forEach((doc) {
  //     i = i + doc['Price'];
  //   });
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(uid)
  //       .collection('Total')
  //       .doc('Total')
  //       .set({'Total Price': i});
  // });

  // FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc(uid)
  //     .collection('Total')
  //     .doc('Total')
  //     .get()
  //     .then((DocumentSnapshot snap) {
  //   if (snap.exists) {
  //     double i = 0;

  //     FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(uid)
  //         .collection('Cart')
  //         .get()
  //         .then((QuerySnapshot querySnapshot) {
  //       querySnapshot.docs.forEach((doc) {
  //         i = i + doc['Price'];
  //       });
  //       FirebaseFirestore.instance
  //           .collection('Users')
  //           .doc(uid)
  //           .collection('Total')
  //           .doc('Total')
  //           .set({'Total Price': i});
  //     });

  //     setState(() {
  //       sum = snap['Total Price'];
  //     });
  //   }
  // });
  // }

  final Stream<QuerySnapshot> cart_items = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Cart')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    setup();

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

    // setState(() {
    //   total(sum);
    // });

    double x = 0;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // CollectionReference user_collection = FirebaseFirestore.instance.collection('Users');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Fav()));
              },
              icon: Icon(
                Icons.thumb_up_sharp,
                color: Colors.black,
              )),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: cart_items,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Container(
                    height: height * 0.7,
                    width: width,
                    child: Center(child: Lottie.asset('assets/loading.json'))));
          }

          if (check == false) {
            return Scaffold(
                body: Container(
                    height: height * 0.7,
                    width: width,
                    child: Center(child: Lottie.asset('assets/loading.json'))));
          }

          if (sum != 0) {
            return new ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                // sum = sum + data['Price'];
                // FirebaseFirestore.instance.collection('Users').doc(uid).collection('Total').doc('Total').set({'Total Price':sum});

                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      width * 0.001, height * 0.02, width * 0.001, 0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      height: height * 0.30,
                      width: width,
                      child: Row(
                        children: [
                          Image.network(data['Image'],
                              height: height * 0.3, width: width * 0.4),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: width * 0.55,
                                  child: Center(
                                      child: Text(data['Name'].toString()))),
                              Wrap(children: [
                                Text(
                                  '\$' + data['Price'].toString(),
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              IconButton(
                                  onPressed: () {
                                    var docId = document.id;
                                    print(docId);

                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(uid)
                                        .collection('Cart')
                                        .doc(docId)
                                        .delete();

                                    setState(() {
                                      sum = sum - data['Price'];
                                    });
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
          return Center(child: Text('No Items in cart'));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: height * 0.1,
          width: width,
          color: Colors.green[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                  child: Text('Add More')),
              InkWell(
                onTap: () async {
                  Fluttertoast.showToast(
                      msg: "Order Placed",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color(0xff7beed9),
                      textColor: Colors.black,
                      fontSize: 16.0);

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
                },
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Place Order',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      'Total:\$$sum',
                      style: TextStyle(color: Colors.green[400]),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
