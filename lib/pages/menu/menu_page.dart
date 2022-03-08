import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/cubits/menu_cubit.dart';
import 'package:simple_pizza_app/pages/menu/widgets/menu_cards.dart';
import 'package:simple_pizza_app/widgets/bottom_bar.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: themeLightGrey,
      appBar: AppBar(
        title: const Text('Menu', style: TextStyle(color: Colors.white)),
        //centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      bottomNavigationBar: BottomBar(0),
      body: BlocBuilder<MenuCubit, MenuState>(builder: (context, state) {
        if (state is MenuLoadedState) {
          return Column(children: <Widget>[
            Expanded(
                child: state.items.isNotEmpty
                    ? RefreshIndicator(
                        child: ListView(children: <Widget>[
                          //todo: maybe a better way! remove hardcode
                          const Padding(
                              padding:
                                  EdgeInsets.only(bottom: 4, left: 16, top: 20),
                              child: Text("Pizzas",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          MenuCards(items: state.pizzas),
                          const Divider(
                            height: 20,
                            thickness: 0.5,
                            indent: 12,
                            endIndent: 12,
                            color: themeExtraLightGrey,
                          ),
                          const Padding(
                              padding:
                                  EdgeInsets.only(bottom: 4, left: 16, top: 32),
                              child: Text("Beverages",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          MenuCards(items: state.beverages),
                          const Divider(
                            height: 20,
                            thickness: 0.5,
                            indent: 12,
                            endIndent: 12,
                            color: themeExtraLightGrey,
                          ),
                          const Padding(
                              padding:
                                  EdgeInsets.only(bottom: 4, left: 16, top: 32),
                              child: Text("Other",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          MenuCards(items: state.other),
                          const SizedBox(height: 10),
                        ]),
                        onRefresh: () {
                          return context
                              .read<MenuCubit>()
                              .getData(emitLoadingState: false);
                        })
                    : const Center(
                        child: Text(
                        'No data. Pull down to refresh', //todo: all errors in a class!
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      )))
          ]);
        }
        //todo: widget
        return const Center(
          child: SpinKitWave(color: themeLightGrey),
        );
      }),
    );
  }
}
