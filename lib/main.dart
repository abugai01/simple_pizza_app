import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/cubits/cart_cubit.dart';
import 'package:simple_pizza_app/cubits/menu_cubit.dart';
import 'package:simple_pizza_app/cubits/profile_cubit.dart';
import 'package:simple_pizza_app/pages/home_page.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_cubit.dart';
import 'package:simple_pizza_app/services/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //todo: put auth cubit above!
    return Provider<FirestoreDatabase>(
      create: (_) => FirestoreDatabase(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
              create: (context) =>
                  AuthCubit(context.read<FirestoreDatabase>())),
          BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(
                  context.read<FirestoreDatabase>(),
                  context.read<AuthCubit>())),
          BlocProvider<MenuCubit>(
              create: (context) =>
                  MenuCubit(context.read<FirestoreDatabase>())),
          BlocProvider<CartCubit>(
              create: (context) =>
                  CartCubit(context.read<FirestoreDatabase>())),
        ],
        child: MaterialApp(
          title: 'Pizza App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
            primarySwatch: themePink,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
