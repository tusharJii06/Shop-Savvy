import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../minor_screens/edit_store.dart';
import '../models/product_model.dart';

class VisitStore extends StatefulWidget {
  final String suppId;

  const VisitStore({Key? key, required this.suppId}) : super(key: key);

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  bool following = false;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
        .collection('products')
        .where('sid', isEqualTo: widget.suppId)
        .snapshots();
    CollectionReference suppliers =
        FirebaseFirestore.instance.collection('suppliers');

    return FutureBuilder<DocumentSnapshot>(
      future: suppliers.doc(widget.suppId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
              toolbarHeight: 100,
              flexibleSpace: Image.asset(
                "images/inapp/coverimage.jpg",
                fit: BoxFit.cover,
              ),
              leading: const YellowBackButton(),
              title: Row(
                children: [
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.yellow),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            data['storelogo'],
                            fit: BoxFit.cover,
                          ))),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(data['storename'].toString().toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.yellow)),
                          ],
                        ),
                        data['sid'] == FirebaseAuth.instance.currentUser!.uid
                            ? Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    border: Border.all(
                                        width: 3, color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EditStore(data: data,)));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('Edit'),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    border: Border.all(
                                        width: 3, color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      following = !following;
                                    });
                                  },
                                  child: following == true
                                      ? const Text("UNFOLLOW")
                                      : const Text("FOLLOW"),
                                ),
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: _prodcutsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Material(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                      'This store \n\n has no items yet !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Acme',
                          letterSpacing: 1.5),
                    ));
                  }

                  return SingleChildScrollView(
                    child: StaggeredGridView.countBuilder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        crossAxisCount: 2,
                        itemBuilder: (context, index) {
                          return ProductModel(
                            products: snapshot.data!.docs[index],
                          );
                        },
                        staggeredTileBuilder: (context) =>
                            const StaggeredTile.fit(1)),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
