import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/cubits/item_cubit.dart';
import 'package:simple_pizza_app/pages/item/item_page.dart';
import 'package:simple_pizza_app/services/database.dart';

//todo: maybe it should be one page.. think about it
//todo: what if item is no longer available? should be in the query I think!
class ItemPageWrapper extends StatelessWidget {
  final String id;
  final String? name;

  ItemPageWrapper(this.id, {this.name});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemCubit>(
        create: (context) =>
            ItemCubit(context.read<FirestoreDatabase>(), id: id),
        child: BlocBuilder<ItemCubit, ItemState>(builder: (context, state) {
          if (state is ItemLoadedState) {
            return ItemPage(state.item);
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  name ?? 'Oops', //todo: remove oops
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                elevation: 1,
                centerTitle: true,
                backgroundColor: Colors.white,
                //centerTitle: true,
              ),
              body:
                  //todo padding?
                  Center(
                      child: (state is ItemErrorState)
                          ? Text(state.error)
                          : const SpinKitWave(color: themeLightGrey)),
            );
          }
        }));
  }
}
