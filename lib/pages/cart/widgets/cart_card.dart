import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/helpers/functions.dart';
import 'package:simple_pizza_app/helpers/screen_navigation.dart';
import 'package:simple_pizza_app/models/item.dart';
import 'package:simple_pizza_app/pages/cart/widgets/incrementor.dart';
import 'package:simple_pizza_app/pages/item/item_page.dart';

class CartCard extends StatelessWidget {
  final Item item;
  final int quantity;
  final Function onDismissed;
  final Function onAdd;
  final Function onSubtract;

  CartCard(
      {required this.item,
      required this.quantity,
      required this.onDismissed,
      required this.onAdd,
      required this.onSubtract});

  @override
  Widget build(BuildContext context) {
    //double listTileHeight = 35;

    return GestureDetector(
      onTap: () {
        changeScreen(context, ItemPage(item));
      },
      child: Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(
            color: themeLightGrey,
            child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Swipe to delete",
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )))),
        key: Key(item.id),
        onDismissed: (direction) => onDismissed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.grey[300]!),
            )),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: item.image,
                      placeholder: (context, url) =>
                          const SpinKitFadingCircle(color: themeLightGrey),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.name, style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        formatWithCurrency(
                                            item.price * quantity),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 2),
                                    //Expanded(child: Container()),
                                    Text("Quantity: " + quantity.toString(),
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12))
                                  ]),
                              Expanded(child: Container()),
                              Incrementor(
                                quantity: item.quantity,
                                onAdd: onAdd,
                                onSubtract: onSubtract,
                              ),
                              const SizedBox(width: 10),
                            ]),
                        //TODO: change to price x quantity calculation - normal way
                      ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
