import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pizza_app/cubits/profile_cubit.dart';
import 'package:simple_pizza_app/helpers/screen_navigation.dart';
import 'package:simple_pizza_app/pages/profile/screens/addresses_page.dart';
import 'package:simple_pizza_app/pages/profile/screens/personal_info_page.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_cubit.dart';
import 'package:simple_pizza_app/pages/sign_in/sign_in_page.dart';
import 'package:simple_pizza_app/widgets/bottom_bar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? name = context.read<ProfileCubit>().profile?.name;
    String? phone = context.read<ProfileCubit>().profile?.phone;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        elevation: 0,
        automaticallyImplyLeading: false,
        //centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 15),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            const SizedBox(width: 15),
            const CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage('assets/images/pizza.png')),
            const SizedBox(width: 15),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  name == null
                      ? Container()
                      : Text(name, style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 5),
                  Text(phone ?? 'No phone'), //todo: null safety
                ]),
          ]),
          Divider(
            height: 24,
            thickness: 0.5,
            indent: 12,
            endIndent: 12,
            color: Colors.grey[350],
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.accessibility_new),
            title: const Text("Personal info"),
            trailing: null,
            onTap: () => changeScreen(context, PersonalInfoPage()),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.maps_home_work),
            title: const Text("Addresses"),
            trailing: null,
            onTap: () => changeScreen(context, AddressesPage()),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Sign out"),
            textColor: Colors.red,
            trailing: null,
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  showSignOutConfirmWindow(context),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(3),
    );
  }

  AlertDialog showSignOutConfirmWindow(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthCubit>().signOut();
            //Navigator.pop(context);
            //todo: implement sign out!!!! bitch!
            changeScreen(context, SignInPage());
          },
          child: const Text('Logout', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
