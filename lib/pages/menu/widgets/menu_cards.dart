import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/cubits/cart_cubit.dart';
import 'package:simple_pizza_app/helpers/screen_navigation.dart';
import 'package:simple_pizza_app/models/item.dart';
import 'package:simple_pizza_app/pages/item/item_page.dart';

class MenuCards extends StatelessWidget {
  final List<Item> items;

  MenuCards({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: items.length,
      physics:
          const NeverScrollableScrollPhysics(), // To disable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (BuildContext context, int index) {
        return MenuCard(items[index]);
      },
    );
  }
}

class MenuCard extends StatelessWidget {
  final Item item;

  MenuCard(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeScreen(context, ItemPage(item));
      },
      child: Card(
        color: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 180,
                    //color: Colors.red,
                    //padding: EdgeInsets.all(5),
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
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(item.name)),
                Row(children: [
                  Text(
                    item.priceFormatted,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Container()),
                  Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            context.read<CartCubit>().addItemToCart(item);
                            HapticFeedback.vibrate();
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 22,
                          ))),
                ])
              ]),
        ),
      ),
    );
  }
}
