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
import '../providers/cart_provider.dart';
import '../providers/wish_provider.dart';
class CartModel extends StatelessWidget {
  const CartModel({
    Key? key,
    required this.product,required this.cart,
  }) : super(key: key);

  final Product product;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 120,
                child: Image.network(
                  product.imagesUrl.first,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.price.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                BorderRadius.circular(25)),
                            child: Row(
                              children: [
                                product.qty == 1
                                    ? IconButton(
                                    onPressed: () {
                                      // cart.removeItem(product);
                                      showCupertinoModalPopup<
                                          void>(
                                          context: context,
                                          builder: (BuildContext) =>
                                              CupertinoActionSheet(
                                                title: Text(
                                                    'Remove Text'),
                                                message: Text(
                                                    'Are u sure to delete Item?'),
                                                actions: <CupertinoActionSheetAction>[
                                                  CupertinoActionSheetAction(
                                                    child: Text(
                                                        'Move to Wishlist'),
                                                    onPressed:
                                                        ()async {
                                                      context
                                                          .read<Wish>()
                                                          .getWishItems
                                                          .firstWhereOrNull(
                                                              (element) =>
                                                          element.documentId == product.documentId)!=
                                                          null ?context.read<Cart>().removeItem(product) :
                                                      await context.read<Wish>()
                                                          .addWishItem(
                                                        product.name,
                                                        product.price,
                                                        1,
                                                        product.qntty,
                                                        product.imagesUrl,
                                                        product.documentId,
                                                        product.suppId,
                                                      );
                                                      context.read<Cart>().removeItem(product);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  CupertinoActionSheetAction(
                                                    child: Text(
                                                        'Delete Item'),
                                                    onPressed:
                                                        () {
                                                      context.read<Cart>().removeItem(product);
                                                      Navigator.pop(
                                                          context);
                                                    },
                                                  ),
                                                ],
                                                cancelButton:
                                                TextButton(
                                                  onPressed:
                                                      () {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color:Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ));
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      size: 18,
                                    ))
                                    : IconButton(
                                    onPressed: () {
                                      cart.reduceByOne(product);
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.minus,
                                      size: 18,
                                    )),
                                Text(
                                  product.qty.toString(),
                                  style: product.qty == product.qntty
                                      ? TextStyle(
                                      fontSize: 20,
                                      color: Colors.red)
                                      : TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                    onPressed: product.qty ==
                                        product.qntty
                                        ? null
                                        : () {
                                      cart.increment(product);
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.plus,
                                      size: 18,
                                    )),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
