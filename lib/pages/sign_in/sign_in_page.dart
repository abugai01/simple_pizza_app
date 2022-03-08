import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_cubit.dart';
import 'package:simple_pizza_app/pages/sign_in/widgets/phone_sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PhoneSignInForm(
                model: authCubit.phoneSignInForm,
                submitHandler: authCubit.submitPhoneSignIn,
                toggleHandler: authCubit.toggleFormType)),
      ),
      //backgroundColor: Colors.grey[200],
    );
  }
}
