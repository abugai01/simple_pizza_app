import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/helpers/screen_navigation.dart';
import 'package:simple_pizza_app/models/item.dart';
import 'package:simple_pizza_app/pages/item/widgets/item_page_wrapper.dart';

class OrderItemCard extends StatelessWidget {
  final Item item;

  OrderItemCard(this.item);

  @override
  Widget build(BuildContext context) {
    //double listTileHeight = 35;

    return GestureDetector(
      onTap: () {
        // In contrast to Menu page or Cart page, here we want to load item info first, in case it has been updated since the moment the order was made (or maybe the item is no longer available at all)
        changeScreen(
            context,
            ItemPageWrapper(item.id,
                name: item.name)); //tODO: sure it is needed here?
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey[300]!),
          )),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(item.priceFormatted,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 2),
                                      //Expanded(child: Container()),
                                      Text(
                                          "Subtotal: " + item.subtotalFormatted,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12))
                                    ]),
                                Expanded(child: Container()),
                                Container(
                                    height: 22,
                                    width: 22,
                                    decoration: const BoxDecoration(
                                        color: themeYellow,
                                        shape: BoxShape.circle),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'x' + item.quantity.toString(),
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    )),
                                const SizedBox(width: 12),
                              ]),
                          //TODO: change to price x quantity calculation - normal way
                        ]),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
