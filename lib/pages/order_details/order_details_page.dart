import 'package:flutter/material.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/models/order.dart';
import 'package:simple_pizza_app/pages/order_details/widgets/order_item_card.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  OrderDetailsPage(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order ' + order.orderCode,
            style: const TextStyle(fontWeight: FontWeight.normal)),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount:
            order.items.length + 2, // one for the header and one for the footer
        itemBuilder: (context, index) {
          //todo maybe separate mvc too
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(Icons.pending_outlined,
                        size: 22, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 12),
                    Text(
                      order.statusText,
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: <Widget>[
                    Icon(Icons.date_range,
                        size: 22, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 12),
                    Text(
                      order.createdAtFormattedWithTime,
                      style:
                          const TextStyle(fontSize: 13, color: themeDarkGrey),
                    ),
                  ]),
                  const SizedBox(height: 15),
                  const Divider(
                    height: 10,
                    thickness: 0.5,
                    //indent: 5,
                    //endIndent: 5,
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          } else if (index > 0 && index <= order.items.length) {
            return OrderItemCard(order.items[index - 1]);
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  const Text(
                    "Order summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text("Items: " + order.items.length.toString()),
                  const SizedBox(height: 10),
                  Text(
                    "Total: " + order.totalFormatted,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
