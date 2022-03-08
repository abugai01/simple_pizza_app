import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/helpers/screen_navigation.dart';
import 'package:simple_pizza_app/helpers/ui_messages.dart';
import 'package:simple_pizza_app/pages/home_page.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_service.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/sign_in_model.dart';
import 'package:simple_pizza_app/services/database.dart';
import 'package:simple_pizza_app/widgets/show_snack_bar_message.dart';

import 'sign_in_controller.dart';

//todo: rewrite normal way!
class SignInForm extends StatefulWidget {
  SignInForm({required this.controller});

  final SignInController controller;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = context.read<FirestoreDatabase>();

    //todo: actually needed?
    return Provider<SignInController>(
      create: (_) => SignInController(auth: auth),
      child: Consumer<SignInController>(
        builder: (_, controller, __) => SignInForm(controller: controller),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.controller.submit();
      changeScreen(context, HomePage());
    } on FirebaseAuthException catch (e) {
      showSnackBarMessage(context, message: ErrorMessages.signInError);
    }
  }

  void _nameEditingComplete(SignInModel? model) {
    if (model == null) return;

    final newFocus = model.nameValidator.isValid(model.name)
        ? _phoneFocusNode
        : _nameFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _phoneEditingComplete(SignInModel? model) {
    if (model == null) return;

    final newFocus = model.phoneValidator.isValid(model.phone)
        ? _emailFocusNode
        : _phoneFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _emailEditingComplete(SignInModel? model) {
    if (model == null) return;

    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.controller.toggleFormType();

    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();

    _nameFocusNode.unfocus();
    _phoneFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  List<Widget> _buildChildren(SignInModel? model) {
    return [
      _buildNameTextField(model),
      _buildPhoneTextField(model),
      _buildEmailTextField(model),
      _buildPasswordTextField(model),
      const SizedBox(height: 8.0),
      ElevatedButton(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              model!.primaryButtonText,
              style: buttonTextStyle(),
              textAlign: TextAlign.center,
            )),
        onPressed: _submit,
        style: signInPrimaryButtonStyle,
      ),
      const SizedBox(height: 4.0),
      ElevatedButton(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              model.secondaryButtonText,
              style: buttonTextStyle(color: themePink),
              textAlign: TextAlign.center,
            )),
        onPressed: _toggleFormType,
        style: signInSecondaryButtonStyle,
      ),
    ];
  }

  //todo: ENGLISH
  Widget _buildNameTextField(SignInModel? model) {
    return (model?.formType == SignInFormType.register)
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'What is your name?',
                errorText:
                    "Incorrect name format", //todo: errorMessages or not?
                enabled: model?.isLoading == false,
              ),
              autocorrect: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onChanged: widget.controller.updateName,
              onEditingComplete: () => _nameEditingComplete(model),
            ))
        : Container();
  }

  Widget _buildPhoneTextField(SignInModel? model) {
    return (model?.formType == SignInFormType.register)
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              decoration: InputDecoration(
                labelText: 'Phone',
                hintText: '+79123456789',
                errorText: "Incorrect phone",
                enabled: model?.isLoading == false,
              ),
              autocorrect: false,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: widget.controller.updatePhone,
              //todo: uncomment
              onEditingComplete: () => _phoneEditingComplete(model),
            ))
        : Container();
  }

  Widget _buildEmailTextField(SignInModel? model) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: TextField(
          controller: _emailController,
          focusNode: _emailFocusNode,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'hello@example.com',
            errorText: model?.emailErrorText,
            enabled: model?.isLoading == false,
          ),
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: widget.controller.updateEmail,
          onEditingComplete: () => _emailEditingComplete(model),
        ));
  }

  Widget _buildPasswordTextField(SignInModel? model) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: TextField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: model?.passwordErrorText,
            enabled: model?.isLoading == false,
          ),
          obscureText: true,
          textInputAction: TextInputAction.done,
          onChanged: widget.controller.updatePassword,
          onEditingComplete: _submit,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SignInModel>(
        stream: widget.controller.modelStream,
        initialData: SignInModel(),
        builder: (context, snapshot) {
          final SignInModel? model = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
