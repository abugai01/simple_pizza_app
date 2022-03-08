import 'package:flutter/material.dart';
import 'package:simple_pizza_app/helpers/screen_navigation.dart';
import 'package:simple_pizza_app/models/order.dart';
import 'package:simple_pizza_app/pages/order_details/order_details_page.dart';

class OrderCards extends StatelessWidget {
  final List<Order> orders;

  OrderCards({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        return orderTileBuilder(orders[index], context);
      },
    );
  }

  Widget orderTileBuilder(Order order, BuildContext context) {
    //double listTileHeight = 35;
    return Column(children: <Widget>[
      ListTile(
        onTap: () {
          changeScreen(context, OrderDetailsPage(order));
        },
        title: Row(children: <Widget>[
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(order.statusText,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(width: 4),
                      RichText(
                        text: TextSpan(
                          text: order.statusEmoji,
                          style: const TextStyle(fontFamily: 'EmojiOne'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(order.createdAtText,
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
            Text(order.totalFormatted,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 6),
            Text(order.itemsLengthFormatted,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
        ]),
        //todo: is it needed at all?
        trailing: IconButton(
          enableFeedback: false,
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            //todo: implement?
          },
        ),
      ),
      Divider(
        height: 24,
        thickness: 0.5,
        indent: 12,
        endIndent: 12,
        color: Colors.grey[350],
      ),
    ]);
  }
}
