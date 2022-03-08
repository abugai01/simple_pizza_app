import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_pizza_app/helpers/screen_navigation.dart';
import 'package:simple_pizza_app/pages/profile/personal_info_page.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_service.dart';
import 'package:simple_pizza_app/pages/sign_in/sign_in_page.dart';
import 'package:simple_pizza_app/widgets/bottom_bar.dart';
import 'package:simple_pizza_app/widgets/show_confirmation_window.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 10),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.accessibility_new),
            title: const Text("Personal info"),
            trailing: null,
            onTap: () => changeScreen(context, PersonalInfoPage()),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Sign Out"),
            textColor: Colors.red,
            trailing: null,
            onTap: () => showConfirmationWindow(context, action: () {
              Provider.of<AuthBase>(context, listen: false).signOut();
              changeScreenReplacement(context, SignInPage());
            },
                subtitle: 'Are you sure you want to sign out?',
                confirmText: 'Sign Out'),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(3),
    );
  }
}
