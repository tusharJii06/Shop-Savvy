import 'package:badges/badges.dart%20';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:multi_store_app/main_screens/category.dart';
import 'package:multi_store_app/main_screens/dashboard.dart';
import 'package:multi_store_app/main_screens/home.dart';
import 'package:multi_store_app/main_screens/stores.dart';
import 'package:multi_store_app/main_screens/upload_product.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);

  @override
  _SupplierHomeScreenState createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  final List _tabs = const [
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),
    DashboardScreen(),
    UploadProductScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('deliverystatus', isEqualTo: 'preparing')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child:  Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            body: _tabs[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Category',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.shop),
                  label: 'Stores',
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                      showBadge: snapshot.data!.docs.isEmpty? false:true,
                      padding: EdgeInsets.all(4),
                      badgeColor: Colors.yellow,
                      badgeContent: Text(
                        snapshot.data!.docs
                            .length
                            .toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      child: const Icon(Icons.dashboard)),
                  label: 'Dashboard',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: 'Upload',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          );
        });
  }
}
