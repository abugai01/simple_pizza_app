import 'dart:async';

import 'package:simple_pizza_app/pages/sign_in/mvc/auth_service.dart';

import 'sign_in_model.dart';

//todo: rewrite
class SignInController {
  SignInController({required this.auth});

  final AuthBase auth;
  final StreamController<SignInModel> _modelController =
      StreamController<SignInModel>();
  SignInModel _model = SignInModel();

  Stream<SignInModel> get modelStream => _modelController.stream;

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == SignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = _model.formType == SignInFormType.signIn
        ? SignInFormType.register
        : SignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updateName(String name) => updateWith(name: name);
  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String? email,
    String? password,
    String? name,
    SignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    // update model
    _model = _model.copyWith(
      email: email,
      password: password,
      name: name,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    // add updated model to _modelController
    _modelController.add(_model);
  }
}
