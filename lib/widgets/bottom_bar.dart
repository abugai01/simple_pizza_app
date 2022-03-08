import 'package:flutter/material.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/helpers/screen_navigation.dart';
import 'package:simple_pizza_app/pages/cart/cart_page.dart';
import 'package:simple_pizza_app/pages/menu/menu_page.dart';
import 'package:simple_pizza_app/pages/orders/orders_page.dart';
import 'package:simple_pizza_app/pages/profile/profile_page.dart';

class BottomBar extends StatefulWidget {
  final int selectedIndex;

  BottomBar(this.selectedIndex);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  //final double verticalPadding = 5;

  @override
  Widget build(BuildContext context) {
    const double verticalPadding = 3;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 24,
      backgroundColor: white,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle:
          const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
      unselectedLabelStyle:
          const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                child: Icon(Icons.flash_on_outlined)),
            label: 'Menu'),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Icon(Icons.shopping_cart),
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              child: Icon(Icons.checklist_rtl)),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              child: Icon(Icons.person)),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: onItemTapped,
    );
  }

  void onItemTapped(int index) {
    if (index == widget.selectedIndex) return;

    switch (index) {
      case 0:
        changeScreenWithoutAnimation(context, MenuPage());
        break;
      case 1:
        changeScreenWithoutAnimation(context, CartPage());
        break;
      case 2:
        changeScreenWithoutAnimation(context, OrdersPage());
        break;
      case 3:
        changeScreenWithoutAnimation(context, ProfilePage());
        break;
    }
  }
}
