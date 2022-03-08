import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:simple_pizza_app/cubits/profile_cubit.dart';
import 'package:simple_pizza_app/pages/menu/menu_page.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_service.dart';
import 'package:simple_pizza_app/pages/sign_in/sign_in_page.dart';
import 'package:simple_pizza_app/services/database.dart';
import 'package:simple_pizza_app/widgets/custom_loading_indicator.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user == null) {
            return SignInPage();
            //todo: on login error (wrong passowrd, etc.)
          }

          context.read<FirestoreDatabase>().uid = user.uid;

          // Making sure a document is created in the 'users' collections when a new user signs up
          context.read<ProfileCubit>().createIfNew(email: user.email);

          return MenuPage();
        }
        return Scaffold(body: CustomLoadingIndicator());
      },
    );
  }
}
