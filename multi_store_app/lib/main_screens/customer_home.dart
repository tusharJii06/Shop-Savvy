import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/main_screens/cart.dart';
import 'package:multi_store_app/main_screens/profile.dart';
import 'package:multi_store_app/main_screens/stores.dart';
import 'package:multi_store_app/main_screens/visit_store.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/snackbar.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:collection/collection.dart';
import '../models/product_model.dart';
import 'category.dart';
import 'package:badges/badges.dart ';

import 'home.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;
  final List _tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          items: [
      BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Category',
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.shop),
        label: 'Stores',
        ),
        BottomNavigationBarItem(
        icon:
        Badge(
        showBadge: context.read<Cart>().getItems.isEmpty? false:true,
        padding: EdgeInsets.all(4),
        badgeColor: Colors.yellow,
        badgeContent: Text(context
            .watch<Cart>()
            .getItems
            .length
            .toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
         child :const Icon(Icons.shopping_cart)),
        label: 'Cart',

        ),
        const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
        ),
        ],
        onTap: (index) {
        setState(() {
        _selectedIndex = index;
        });
        },
        )
    ,
    );
  }
}
