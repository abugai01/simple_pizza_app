import 'package:simple_pizza_app/models/helpers/validator.dart';

enum PhoneSignInStatus { CODE_WAITING, CODE_SENT }
enum PhoneSignInFormType { SIGN_IN, REGISTER }

class PhoneSignIn {
  String phoneNumber;
  String verificationId;
  String smsCode;
  String? name;
  PhoneSignInFormType formType;
  PhoneSignInStatus status;
  List<String?> errors = [];
  List<Validator> phoneNumberValidators = [];
  List<Validator> smsCodeValidators = [];
  List<Validator> nameValidators = [];
  List<Validator> cityValidators = [];

  PhoneSignIn({
    this.phoneNumber = '',
    this.smsCode = '',
    this.verificationId = '',
    this.name,
    this.formType = PhoneSignInFormType.SIGN_IN,
    this.status = PhoneSignInStatus.CODE_WAITING,
  }) {
    initValidators();
  }

  bool whenValidateSmsCode() {
    return status == PhoneSignInStatus.CODE_SENT ? true : false;
  }

  bool whenValidateName() {
    return formType == PhoneSignInFormType.REGISTER ? true : false;
  }

  String? validateName() {
    return Validator.validateField(name, nameValidators);
  }

  String? validatePhoneNumber() {
    return Validator.validateField(phoneNumber, phoneNumberValidators);
  }

  String? validateSmsCode() {
    return Validator.validateField(smsCode, smsCodeValidators);
  }

  void initValidators() {
    phoneNumberValidators.addAll([
      Validator(
          function: Validator.noEmptyValidator,
          message: 'Enter phone number'), //todo: from error messages!
      Validator(function: Validator.phoneNumberValidator)
    ]);
    smsCodeValidators.addAll([
      Validator(
          function: Validator.noEmptyValidator,
          message: 'Enter verification code',
          when: whenValidateSmsCode),
      Validator(
          function: Validator.minStringLengthValidator,
          when: whenValidateSmsCode,
          param: 6),
      Validator(
          function: Validator.maxStringLenghtValidator,
          when: whenValidateSmsCode,
          param: 6)
    ]);
    nameValidators.addAll([
      Validator(
          function: Validator.noEmptyValidator,
          message: 'Enter name',
          when: whenValidateName)
    ]);
  }

  bool validate() {
    List<Map<dynamic, List<Validator>>> data = [
      {name: nameValidators},
      {phoneNumber: phoneNumberValidators},
      {smsCode: smsCodeValidators},
    ];
    errors = Validator.validate(data);
    return errors.isEmpty ? true : false;
  }

  void toggleType() {
    clear();
    formType = formType == PhoneSignInFormType.SIGN_IN
        ? PhoneSignInFormType.REGISTER
        : PhoneSignInFormType.SIGN_IN;
  }

  void clear() {
    name = '';
    phoneNumber = '';
    verificationId = '';
    smsCode = '';
  }

  void init() {
    clear();
    update(status: PhoneSignInStatus.CODE_WAITING);
  }

  void update(
      {String? phoneNumber,
      String? verificationId,
      String? smsCode,
      String? name,
      PhoneSignInStatus? status}) {
    if (phoneNumber != null) {
      this.phoneNumber = phoneNumber;
    }
    if (name != null) {
      this.name = name;
    }
    if (verificationId != null) {
      this.verificationId = verificationId;
    }
    if (smsCode != null) {
      this.smsCode = smsCode;
    }
    if (status != null) {
      this.status = status;
    }
  }

  String get primaryButtonText {
    return status == PhoneSignInStatus.CODE_SENT ? 'Sign In' : 'Get code';
  }

  String get secondaryButtonText {
    return formType == PhoneSignInFormType.SIGN_IN
        ? 'Not registered? Create an account'
        : 'Already registered? Login';
  }
}
