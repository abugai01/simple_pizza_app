import 'package:simple_pizza_app/pages/sign_in/mvc/validators.dart';

enum SignInFormType { signIn, register }

class SignInModel with EmailAndPasswordValidators {
  SignInModel({
    this.email = '',
    this.password = '',
    this.formType = SignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,

    //todo: think and remove
    this.phone = '',
    this.name = '',
  });
  final String email;
  final String password;
  final SignInFormType formType;
  final bool isLoading; //todo: remove this loading shit!
  final bool submitted;

  //todo: added myself, probably remove
  final String phone;
  final String name;

  Map<String, Validator> validators = {'email': Validator()};

  String get primaryButtonText {
    return formType == SignInFormType.signIn ? 'Sign In' : 'Sign Up';
  }

  String get secondaryButtonText {
    return formType == SignInFormType.signIn
        ? 'First time? Create an account'
        : 'Already registered? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String? get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String? get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  //todo: why needed?
  SignInModel copyWith({
    String? email,
    String? password,
    String? phone,
    String? name,
    SignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    return SignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }

  //todo: added by myself, probably remove+ null safety
  //Validator get nameValidator => validators['name']!;
  //Validator get phoneValidator => validators['phone']!;
}
