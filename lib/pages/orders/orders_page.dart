import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/cubits/orders_cubit.dart';
import 'package:simple_pizza_app/helpers/ui_messages.dart';
import 'package:simple_pizza_app/pages/orders/widgets/order_cards.dart';
import 'package:simple_pizza_app/services/database.dart';
import 'package:simple_pizza_app/widgets/bottom_bar.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = kToolbarHeight;
    double indicatorWeight = 2;
    double tabBarHeight = appBarHeight - indicatorWeight;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //backgroundColor: themeLightGrey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: Theme.of(context).textTheme.subtitle1,
                    indicatorWeight: indicatorWeight,
                    indicatorColor: Theme.of(context).primaryColor,
                    tabs: [
                      Container(
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text('Active')),
                          height: tabBarHeight),
                      Container(
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text('Completed')),
                          height: tabBarHeight),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(2),
        body: BlocProvider<OrdersCubit>(
          create: (context) => OrdersCubit(context.read<FirestoreDatabase>()),
          child:
              BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
            //print(state);
            if (state is OrdersLoadedState) {
              return TabBarView(children: [
                OrderCards(orders: state.activeOrders),
                OrderCards(orders: state.completedOrders),
              ]);
            } else if (state is OrdersErrorState) {
              return const Center(child: Text(ErrorMessages.errorGeneric));
            } else {
              return const Center(
                child: SpinKitWave(color: themeLightGrey),
              );
            }
          }),
        ),
      ),
    );
  }
}
