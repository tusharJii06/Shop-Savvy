import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app/main_screens/welcome_screen.dart';
import 'package:multi_store_app/providers/product_class.dart';
import 'package:multi_store_app/widgets/alert_dialog.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../minor_screens/place_order.dart';
import '../models/cart_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wish_provider.dart';

class CartScreen extends StatelessWidget {
  final Widget? back;

  const CartScreen({Key? key, this.back}) : super(key: key);

  @override

  Widget build(BuildContext context) {
     double total= context.watch<Cart>().totalPrice;
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            leading: back,
            actions: [
              context.watch<Cart>().getItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDiloag.showMyDiloag(
                            context: context,
                            title: "Clear Cart",
                            content: 'Are u sure to clear Cart',
                            tabNo: () {
                              Navigator.pop(context);
                            },
                            tabYes: () {
                              context.read<Cart>().clearCart();
                              Navigator.pop(context);
                            });
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ))
            ],
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppbarTitle(
              title: 'Cart',
            ),
          ),
          body: context.watch<Cart>().getItems.isNotEmpty
              ? CartItems()
              : EmptyCart(),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Total: \$ ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      total.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                YellowButton(
                  width: 0.45,
                  label: 'CHECK OUT',
                  onPressed:total==0.0?() {}: () {
                    Navigator.push(context, MaterialPageRoute(builder: ( context)=> PlaceOrderScreen()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Consumer<Cart> CartItems() {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return ListView.builder(
            itemCount: cart.count,
            itemBuilder: (context, index) {
              final product = cart.getItems[index];
              return CartModel(product: product,cart:context.read<Cart>());
            });
      },
    );
  }
}


class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your Cart Is Empty !',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(25)),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.5,
              onPressed: () {
                Navigator.canPop(context)
                    ? Navigator.pop(context)
                    : Navigator.pushReplacementNamed(context, '/customer_home');
              },
              child: const Text(
                'Contiue Shopping',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
