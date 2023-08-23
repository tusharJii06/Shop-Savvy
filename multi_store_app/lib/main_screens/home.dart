import 'package:flutter/material.dart';
import 'package:multi_store_app/gallery/accessories_gallery.dart';
import 'package:multi_store_app/gallery/bags_gallery.dart';
import 'package:multi_store_app/gallery/electronics_gallery.dart';
import 'package:multi_store_app/gallery/homegarden_gallery.dart';
import 'package:multi_store_app/gallery/kids_gallery.dart';
import 'package:multi_store_app/gallery/men_gallery.dart';
import 'package:multi_store_app/gallery/shoes_gallery.dart';
import 'package:multi_store_app/gallery/women_gallery.dart';
import 'package:multi_store_app/widgets/fake_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          bottom: const TabBar(
            indicatorColor: Colors.yellow,
            indicatorWeight: 8,
            isScrollable: true,
            tabs: [
              RepeatedTab(label: 'Men'),
              RepeatedTab(label: 'Women'),
              RepeatedTab(label: 'Shoes'),
              RepeatedTab(label: 'Bags'),
              RepeatedTab(label: 'Electronics'),
              RepeatedTab(label: 'Accessories'),
              RepeatedTab(label: 'Home & Garden'),
              RepeatedTab(label: 'Kids'),
              RepeatedTab(label: 'Beauty'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MenGalleryScreen(),
            WomenGalleryScreen(),
            ShoesGalleryScreen(),
            BagsGalleryScreen(),
            ElectronicsGalleryScreen(),
            AccessoriesGalleryScreen(),
            HomeGardenGalleryScreen(),
            KidsGalleryScreen(),
            BagsGalleryScreen(),
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
      ),
    );
  }
}
