import 'package:flutter/material.dart';
import 'package:simple_pizza_app/helpers/ui_messages.dart';
import 'package:simple_pizza_app/models/profile.dart';
import 'package:validators/validators.dart';

//TODO: надо ли stateful?
//TODO: валидации в блок!
//TODO: надо ли в стейт что-то передавать? мб из блока брать лучше?
class ProfileForm extends StatefulWidget {
  final Key formKey; //TODO: нужен ли?
  final Map<String, TextEditingController> controllers;

  ProfileForm({required this.formKey, required this.controllers});

  @override
  ProfileFormState createState() {
    return ProfileFormState();
  }
}

class ProfileFormState extends State<ProfileForm> {
  String labelName = "Name";
  String labelSurname = "Surname";
  String labelPhone = "Phone";
  String labelEmail = "Email";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            // Name
            Flexible(
              child: TextFormField(
                controller: widget.controllers[Profile.NAME],
                decoration: InputDecoration(labelText: labelName),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ErrorMessages.validationErrorMessages.emptyField;
                  } else {
                    if (!isAlpha(value)) {
                      return ErrorMessages
                          .validationErrorMessages.forbiddenSymbols;
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 20),
            // Surname
            Flexible(
              child: TextFormField(
                controller: widget.controllers[Profile.SURNAME],
                decoration: InputDecoration(labelText: labelSurname),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!isAlpha(value)) {
                      return ErrorMessages
                          .validationErrorMessages.forbiddenSymbols;
                    }
                  }
                  return null;
                },
              ),
            ),
          ]),
          const SizedBox(height: 10),
          // Phone
          TextFormField(
            controller: widget.controllers[Profile.PHONE],
            readOnly: true,
            decoration: InputDecoration(labelText: labelPhone),
            //todo: phone validation and mask1
          ),
          const SizedBox(height: 10),
          // Email
          TextFormField(
            controller: widget.controllers[Profile.EMAIL],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: labelEmail),
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (!isEmail(value)) {
                  return ErrorMessages.validationErrorMessages.incorrectEmail;
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
