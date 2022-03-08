import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:simple_pizza_app/config/style.dart';
import 'package:simple_pizza_app/models/auth/phone_sign_in.dart';

// ignore: must_be_immutable
class PhoneSignInForm extends StatelessWidget {
  PhoneSignInForm(
      {required this.model,
      required this.submitHandler,
      required this.toggleHandler,
      Key? key})
      : super(key: key);

  PhoneSignIn model;
  Function submitHandler;
  Function toggleHandler;

  Widget _buildNameTextField() {
    return FormBuilderTextField(
      name: 'name',
      keyboardType: TextInputType.text,
      validator: (value) => model.validateName(),
      onChanged: (value) => model.update(name: value),
      decoration: const InputDecoration(labelText: 'Name'),
    );
  }

  Widget _buildSmsCodeTextField() {
    return FormBuilderTextField(
      name: 'smsCode',
      keyboardType: TextInputType.phone,
      validator: (value) => model.validateSmsCode(),
      onChanged: (value) => model.update(smsCode: value),
      decoration: const InputDecoration(labelText: 'SMS code'),
    );
  }

  Widget _buildPhoneNumberTextField() {
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
        mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
    return FormBuilderTextField(
      name: 'phoneNumber',
      keyboardType: TextInputType.number,
      validator: (value) => model.validatePhoneNumber(),
      onChanged: (value) => model.update(phoneNumber: value),
      inputFormatters: [maskFormatter],
      decoration: const InputDecoration(labelText: 'Phone'),
    );
  }

  List<Widget> _buildFormContent() {
    List<Widget> result = [];
    if (model.status == PhoneSignInStatus.CODE_WAITING) {
      result.add(_buildPhoneNumberTextField());
    }
    if (model.status == PhoneSignInStatus.CODE_SENT) {
      result.add(_buildSmsCodeTextField());
    }
    if (model.formType == PhoneSignInFormType.REGISTER &&
        model.status == PhoneSignInStatus.CODE_WAITING) {
      result.addAll([_buildNameTextField()]);
    }
    return result;
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            model.primaryButtonText,
            style: buttonTextStyle(),
            textAlign: TextAlign.center,
          )),
      onPressed: () => submitHandler(),
      style: signInPrimaryButtonStyle,
    );
  }

  Widget _buildToggleButton() {
    return ElevatedButton(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            model.secondaryButtonText,
            style: buttonTextStyle(color: themePink),
            textAlign: TextAlign.center,
          )),
      onPressed: () => toggleHandler(),
      style: signInSecondaryButtonStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilder(
            initialValue: {
              'name': model.name,
              'smsCode': model.smsCode,
              'phoneNumber': model.phoneNumber
            },
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: _buildFormContent(),
            )),
        const SizedBox(height: 16.0),
        _buildSubmitButton(),
        const SizedBox(height: 4.0),
        Visibility(
            visible: model.status == PhoneSignInStatus.CODE_WAITING,
            child: _buildToggleButton())
      ],
    );
  }
}
