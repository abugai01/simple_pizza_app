abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  //todo: move to ui messages
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email cannot be empty';
  final String invalidPasswordErrorText = 'Password cannot be empty';

  //todo: added myself!
  final StringValidator nameValidator = NonEmptyStringValidator();
  final StringValidator phoneValidator = NonEmptyStringValidator();
}

class Validator {
  List<Rule>? rules;

  // bool validate() {
  //   bool isValid = true;
  //   rules?.map((rule) {
  //     if (!rule.isValid()) {
  //       isValid = false;
  //       return;
  //     }
  //   });
  //   return isValid;
  // }

  static String? noEmptyValidator(dynamic value) {
    if (value == null || value == '') {
      return 'Field cannot be empty'; //todo: move to ui messages!
    }
  }

  static String? validateField<T>(T field, List validators) {
    for (int i = 0; i < validators.length; i++) {
      final result = validators[i](field);
      if (result != null) {
        return result;
      }
    }
  }

  static bool validate<T>(List<Map<T, List<Function>>> data) {
    bool result = true;
    for (int i = 0; i < data.length; i++) {
      data[i].forEach((field, validators) {
        if (validateField(field, validators) != null) {
          result = false;
          return;
        }
      });
    }
    return result;
  }
}

class Rule {
  String? errorMessage;

  bool isValid() {
    return false;
  }
}
