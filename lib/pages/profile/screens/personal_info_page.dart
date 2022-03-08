import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pizza_app/cubits/profile_cubit.dart';
import 'package:simple_pizza_app/helpers/ui_messages.dart';
import 'package:simple_pizza_app/pages/profile/widgets/profile_form.dart';
import 'package:simple_pizza_app/widgets/save_button.dart';

//////////TODO TODO не работает кнопка сохранения!!!!!!! поправить
//TODO: контролеры надо по красоте перенести в блок по аналогии со славиной EmailSignInForm
//TODO: snackbar тоже надо бы показывать с текстом об успехе или неуспехе обновления
class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      //backgroundColor: white,
      appBar: AppBar(
        title: const Text("Personal info",
            style: TextStyle(fontWeight: FontWeight.normal)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        //print(state);
        if (state is ProfileLoadedState) {
          return Column(children: <Widget>[
            Expanded(
                child: ListView(children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: ProfileForm(
                    formKey: state.formKey, controllers: state.controllers),
                //todo: implementation
              ),
            ])),
            //Expanded(child: Container()),
            Container(
                //color: Colors.red,
                height: 65,
                child: SaveButton(function: () {
                  //context.read<ProfileCubit>().saveChanges(); //todo: implementation
                  print("fuck");
                  Navigator.pop(context);
                })),
          ]);
        } else {
          return const Center(child: Text(ErrorMessages.errorGeneric));
        }
      }),
    );
  }
}
