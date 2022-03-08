import 'package:simple_pizza_app/cubits/models/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,

    //todo: think and remove
    this.phone = '',
    this.name = '',
  });
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  //todo: added myself, probably remove
  final String phone;
  final String name;

  Map<String, Validator> validators = {'email': Validator()};

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn ? 'Войти' : 'Создать аккаунт';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Впервые? Зарегистрируйтесь'
        : 'Есть аккаунт? Войти';
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

  EmailSignInModel copyWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }

  //todo: added by myself, probably remove+ null safety
  //Validator get nameValidator => validators['name']!;
  //Validator get phoneValidator => validators['phone']!;
}
