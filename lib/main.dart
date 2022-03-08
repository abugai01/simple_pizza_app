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
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_service.dart';
import 'package:simple_pizza_app/services/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: Provider<FirestoreDatabase>(
        create: (_) => FirestoreDatabase(),
        child: MultiBlocProvider(
          providers: [
            //todo: all of them needed here or not? think
            BlocProvider<ProfileCubit>(
                create: (context) =>
                    ProfileCubit(context.read<FirestoreDatabase>())),
            BlocProvider<MenuCubit>(
                create: (context) =>
                    MenuCubit(context.read<FirestoreDatabase>())),
            BlocProvider<CartCubit>(
                create: (context) =>
                    CartCubit(context.read<FirestoreDatabase>())),
          ],
          child: MaterialApp(
            title: 'Simple Pizza App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme:
                  GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
              primarySwatch: themePink,
            ),
            home: HomePage(),
          ),
        ),
      ),
    );
  }
}
