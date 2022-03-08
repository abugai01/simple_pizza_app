import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pizza_app/helpers/ui_messages.dart';
import 'package:simple_pizza_app/models/profile.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_cubit.dart';
import 'package:simple_pizza_app/services/database.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
  //todo: find out why this is needed (if needed at all)
}

class ProfileLoadedState extends ProfileState {
  final Profile profile;
  final Map<String, TextEditingController> controllers;
  final Key formKey;

  ProfileLoadedState(this.profile,
      {required this.controllers, required this.formKey});

  @override
  List<Object> get props => [profile, controllers];
}

// class FormGenericState extends CustomFormState {
//   final Map<String, TextEditingController> controllers;
//   final Key formKey;
//
//   FormGenericState({
//     required this.controllers,
//     required this.formKey,
//   });
//
//   @override
//   List<Object> get props => [controllers];
// }

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState({this.error = ErrorMessages.errorGeneric});

  @override
  List<Object> get props => [];
}

class ProfileCubit extends Cubit<ProfileState> {
  final Database database;
  final AuthCubit auth;
  late Profile? profile; //TODO: должен быть наверное не null

  Map<String, TextEditingController> controllers = {};
  Key formKey;

  ProfileCubit(this.database, this.auth)
      : formKey = GlobalKey<FormState>(),
        super(ProfileInitState()) {
    loadProfile();
  }

  void fillControllers(Profile? profile) {
    if (profile != null) {
      controllers[Profile.NAME] = TextEditingController(text: profile.name);
      controllers[Profile.SURNAME] =
          TextEditingController(text: profile.surname);
      controllers[Profile.PHONE] = TextEditingController(text: profile.phone);
      controllers[Profile.EMAIL] = TextEditingController(text: profile.email);
    }

    //todo: what if profile is null?
  }

  Future<void> loadProfile() async {
    try {
      emit(ProfileLoadingState());
      profile = await database.getProfile(); //todo: null safety!!!
      if (profile != null) {
        emit(ProfileLoadedState(profile!,
            controllers: controllers, formKey: formKey)); //todo: null safety!!!
        fillControllers(profile);
      } else {
        emit(ProfileErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(ProfileErrorState());
    }
  }

  // void updateExecutor(
  //     {String? name,
  //     String? surname,
  //     String? phone,
  //     String? email,
  //     String? avatar}) async {
  //   try {
  //     //TODO: null safety надо бы обеспечить конечно
  //     executor = executor!.copy(
  //         name: name,
  //         surname: surname,
  //         phone: phone,
  //         email: email,
  //         avatar: avatar);
  //     await database.setExecutor(executor!);
  //     emit(ExecutorLoadedState(executor!)); //TODO: null safety
  //     // await database
  //     //     .executorFuture(executorId: executorId)
  //     //     .then((executor) => emit(LoadedState(executor)));
  //   } catch (e) {
  //     emit(ExecutorErrorState());
  //   }
  // }

  void updateProfile(
      {String? name,
      String? surname,
      String? phone,
      String? email,}) {
    //todo: null safety
    Profile newProfile = profile!.copy(
      name: name,
      surname: surname,
      phone: phone,
      email: email,
    );

    uploadToDatabase(profile: newProfile);
  }

  //todo: remove unnecessary!
  void uploadToDatabase({Profile? profile}) async {
    //todo: null safety?
    if (profile == null) return;
    Map<String, dynamic> data = {};

    try {
      //todo: null safety?
      await database.updateProfile(data: data);
      loadProfile();
    } catch (e) {
      emit(ProfileErrorState());
    }
  }

  void createIfNew(
      {String? name,
        String? surname,
        String? phone,
        String? email,}) async {

  try {
  Profile? profile = await database.getProfile(); //todo: this cant's be null!

  if (profile == null) {
    Profile newProfile = Profile.createNew(name: name, surname: surname, phone: phone, email: email);

    await database.setProfile(data: newProfile.toMap());
    //todo: maybe load profile here?
  }
  } catch (e) {
  emit(ProfileErrorState());
  //todo: what should be emitted if error here?
  }

}
