import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_pizza_app/cubits/cart_cubit.dart';
import 'package:simple_pizza_app/models/item.dart';
import 'package:simple_pizza_app/pages/item/widgets/item_information_row.dart';

class ItemPage extends StatelessWidget {
  final Item item;

  ItemPage(this.item);

  @override
  Widget build(BuildContext context) {
    double pageHorizontalPadding = 18.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        //centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: CachedNetworkImage(
                      imageUrl: item.image,
                      placeholder: (context, url) =>
                          const SpinKitFadingCircle(color: Colors.black),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(children: <Widget>[
                    Text(
                      item.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Expanded(child: Container()),
                    Text(
                      item.priceFormatted,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 13),
                  ),
                  ItemInformationRow(
                      figure1: item.calories,
                      title1: 'kcal',
                      figure2: item.weight,
                      title2: 'grams',
                      figure3: item.size,
                      title3: 'cm'),
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.ingredients,
                    style: const TextStyle(fontSize: 13),
                  ),
                ]),
          ),
          //todo: reuse existing button
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(
                horizontal: pageHorizontalPadding, vertical: 5),
            child: MaterialButton(
              child: const Text(
                "ADD TO CART",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                //side: BorderSide(color: Colors.red),
              ),
              onPressed: () {
                context.read<CartCubit>().addItemToCart(item);
                HapticFeedback.vibrate();
              },
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
