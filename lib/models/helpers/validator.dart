class Validator {
  Function function;
  String? message;
  dynamic param;
  bool Function()? when;

  Validator({required this.function, this.message, this.param, this.when});

//todo: english!
  static String? noEmptyValidator(dynamic value,
      [String? message, dynamic param]) {
    final defaultText = 'This field cannot be empty';
    if (value == null || value == '') {
      return message ?? defaultText;
    }
  }

  static String? minValueValidator(dynamic value,
      [String? message, dynamic param]) {
    final defaultText = 'Значение должно быть больше $param';
    if (value < param) {
      return message ?? defaultText;
    }
  }

  static String? maxValueValidator(dynamic value,
      [String? message, dynamic param]) {
    final defaultText = 'Значение должно быть меньше $param';
    if (value > param) {
      return message ?? defaultText;
    }
  }

  static String? greaterThanValueValidator(dynamic value,
      [String? message, dynamic param]) {
    final defaultText = 'Значение должно быть больше чем $param';
    if (value <= param) {
      return message ?? defaultText;
    }
  }

  static String? lessThanValueValidator(dynamic value,
      [String? message, dynamic param]) {
    final defaultText = 'Значение должно быть меньше чем $param';
    if (value >= param) {
      return message ?? defaultText;
    }
  }

  static String? emailValidator(dynamic value,
      [String? message, dynamic param]) {
    final defaultText = 'Неверный email адрес';
    RegExp regExp = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (regExp.hasMatch(value) == false) {
      return message ?? defaultText;
    }
  }

  static String? phoneNumberValidator(dynamic value,
      [String? message, dynamic param]) {
    final defaultText = 'Неверный формат номера телефона';
    RegExp regExp =
        new RegExp(r"^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{10}$");
    if (regExp.hasMatch(value) == false) {
      return message ?? defaultText;
    }
  }

  static String? minStringLengthValidator(dynamic value,
      [String? message, dynamic param]) {
    final defaultText = 'Строка не должна быть короче $param символов';
    if (value.toString().length < param) {
      return message ?? defaultText;
    }
  }

  static String? maxStringLenghtValidator(dynamic value,
      [String? message, dynamic param]) {
    final defaultText = 'Строка не должна быть длиннее $param символов';
    if (value.toString().length > param) {
      return message ?? defaultText;
    }
  }

  static String? validateField<T>(T field, List<Validator> validators) {
    for (int i = 0; i < validators.length; i++) {
      String? result;
      final func = validators[i].function;
      final message = validators[i].message;
      final param = validators[i].param;
      final when = validators[i].when;
      if (when == null || when() == true) {
        result = func(field, message, param);
      }
      if (result != null) {
        return result;
      }
    }
  }

  static List<String?> validate<T>(List<Map<T, List<Validator>>> data) {
    List<String?> result = [];
    for (int i = 0; i < data.length; i++) {
      data[i].forEach((field, validators) {
        final errorMessage = validateField(field, validators);
        if (errorMessage != null) {
          result.add(errorMessage);
        }
      });
    }
    return result;
  }
}
