import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/helpers/screen_navigation.dart';
import 'package:simple_pizza_app/mvc/show_exception_alert_dialog.dart';
import 'package:simple_pizza_app/pages/home_page.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_service.dart';
import 'package:simple_pizza_app/services/database.dart';
import 'package:simple_pizza_app/widgets/show_snack_bar_message.dart';

import '../../../cubits/models/email_sign_in_model.dart';
import 'sign_in_controller.dart';

//todo: rewrite normal way!
class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({required this.bloc});

  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = context.read<FirestoreDatabase>();

    return Provider<EmailSignInBloc>(
      //create: (_) => EmailSignInBloc(auth: auth, database: database),
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInForm(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
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
      await widget.bloc.submit();
      changeScreen(context, HomePage());
    } on FirebaseAuthException catch (e) {
      showSnackBarMessage(context, message: ErrorMessages.signInError);
    }
  }

  void _nameEditingComplete(EmailSignInModel? model) {
    if (model == null) return;

    final newFocus = model.nameValidator.isValid(model.name)
        ? _phoneFocusNode
        : _nameFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _phoneEditingComplete(EmailSignInModel? model) {
    if (model == null) return;

    final newFocus = model.phoneValidator.isValid(model.phone)
        ? _emailFocusNode
        : _phoneFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _emailEditingComplete(EmailSignInModel? model) {
    if (model == null) return;

    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();

    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();

    _nameFocusNode.unfocus();
    _phoneFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  List<Widget> _buildChildren(EmailSignInModel? model) {
    return [
      _buildNameTextField(model),
      _buildPhoneTextField(model),
      _buildEmailTextField(model),
      _buildPasswordTextField(model),
      const SizedBox(height: 8.0),
      ElevatedButton(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              model!.primaryButtonText,
              style: buttonTextStyle(),
              textAlign: TextAlign.center,
            )),
        onPressed: _submit,
        style: signInPrimaryButtonStyle,
      ),
      SizedBox(height: 4.0),
      ElevatedButton(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
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
  Widget _buildNameTextField(EmailSignInModel? model) {
    return (model?.formType == EmailSignInFormType.register)
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              decoration: InputDecoration(
                labelText: 'Имя',
                hintText: 'Как вас зовут?',
                //errorText: model?.nameErrorText,
                //todo: uncomment
                errorText: "FUCK ME",
                enabled: model?.isLoading == false,
              ),
              autocorrect: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              //onChanged: widget.bloc.updateName,
              //todo: uncomment!!!

              onEditingComplete: () => _nameEditingComplete(model),
            ))
        : Container();
  }

  Widget _buildPhoneTextField(EmailSignInModel? model) {
    return (model?.formType == EmailSignInFormType.register)
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: TextField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              decoration: InputDecoration(
                labelText: 'Телефон',
                hintText: '+79123456789',
                //errorText: model?.phoneErrorText,
                enabled: model?.isLoading == false,
              ),
              autocorrect: false,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              //onChanged: widget.bloc.updatePhone,
              //todo: uncomment
              onEditingComplete: () => _phoneEditingComplete(model),
            ))
        : Container();
  }

  Widget _buildEmailTextField(EmailSignInModel? model) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: TextField(
          controller: _emailController,
          focusNode: _emailFocusNode,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'dog@walker.com',
            errorText: model?.emailErrorText,
            enabled: model?.isLoading == false,
          ),
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: widget.bloc.updateEmail,
          onEditingComplete: () => _emailEditingComplete(model),
        ));
  }

  Widget _buildPasswordTextField(EmailSignInModel? model) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: TextField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          decoration: InputDecoration(
            labelText: 'Пароль',
            errorText: model?.passwordErrorText,
            enabled: model?.isLoading == false,
          ),
          obscureText: true,
          textInputAction: TextInputAction.done,
          onChanged: widget.bloc.updatePassword,
          onEditingComplete: _submit,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel? model = snapshot.data;

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
