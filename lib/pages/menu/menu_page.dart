import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pizza_app/cubits/menu_cubit.dart';
import 'package:simple_pizza_app/helpers/ui_messages.dart';
import 'package:simple_pizza_app/pages/menu/widgets/menu_cards.dart';
import 'package:simple_pizza_app/widgets/bottom_bar.dart';
import 'package:simple_pizza_app/widgets/custom_loading_indicator.dart';

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
          if (state.items.isNotEmpty) {
            return RefreshIndicator(
                child:
                    ListView(children: <Widget>[MenuCards(items: state.items)]),
                onRefresh: () {
                  return context
                      .read<MenuCubit>()
                      .getData(emitLoadingState: false);
                });
          } else {
            return const Center(child: Text(ErrorMessages.noDataPullToRefresh));
          }
        } else if (state is MenuLoadingState) {
          return CustomLoadingIndicator();
        } else if (state is MenuErrorState) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: Text(ErrorMessages.errorGeneric));
        }
      }),
    );
  }
}
