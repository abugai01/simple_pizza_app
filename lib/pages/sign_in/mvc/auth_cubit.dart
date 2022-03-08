import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:simple_pizza_app/models/auth/auth_exception.dart';
import 'package:simple_pizza_app/models/auth/phone_sign_in.dart';
import 'package:simple_pizza_app/models/profile.dart';
import 'package:simple_pizza_app/pages/sign_in/mvc/auth_service.dart';
import 'package:simple_pizza_app/services/database.dart';

part 'auth_state.dart';

//todo: is there a simpler version possible?
class AuthCubit extends Cubit<AuthState> {
  Database database;
  Profile? _profile;
  PhoneSignIn phoneSignInForm = PhoneSignIn();
  final AuthBase _authService = Auth();

  bool _isLogin = false;
  bool _wasLogout = false;

  User? get user => _authService.currentUser;

  AuthCubit(this.database) : super(AuthLoadingState()) {
    //this._authService = Auth();
    tryAutoLogin();
  }

  void tryAutoLogin() {
    if (user != null) {
      _isLogin = true;
      database.uid = user?.uid;
      emit(AuthLoginSuccessState(user: user));
    } else {
      emit(AuthLogoutState(phoneSignInForm));
    }
  }

  void toggleFormType() {
    phoneSignInForm.toggleType();
    emit(AuthLogoutState(phoneSignInForm));
  }

  Future<User?> _signIn(Future<User?> Function() signInMethod) async {
    try {
      return await signInMethod();
    } catch (e) {
      rethrow;
    }
  }

  //todo: why is this even needed?
  Future<void> _updateProfile() async {
    try {
      Profile? profile = await database.getProfile(id: user!.uid);
      if (profile == null) {
        profile = Profile.createNew(
            phone: phoneSignInForm.phoneNumber, name: phoneSignInForm.name);
      }
      String? token = await FirebaseMessaging.instance.getToken();
      profile.token = token;
      database.setProfile(id: user!.uid, data: profile.toMap());
    } catch (e) {
      rethrow;
    }
  }

  //todo: why is this even needed?
  void _codeSentCallback(String verificationId, int? resendToken) {
    phoneSignInForm.update(
        verificationId: verificationId, status: PhoneSignInStatus.CODE_SENT);
    emit(AuthLogoutState(phoneSignInForm));
  }

  Future<void> submitPhoneSignIn() async {
    if (phoneSignInForm.validate() != true) {
      print(phoneSignInForm.errors.first);
      return;
    }
    try {
      emit(AuthLoadingState());
      if (phoneSignInForm.status == PhoneSignInStatus.CODE_WAITING) {
        await _authService.verifyPhoneNumber(
            phoneSignInForm.phoneNumber, _codeSentCallback);
      } else {
        final User? user = await _authService.signInWithSmsCode(
            phoneSignInForm.verificationId, phoneSignInForm.smsCode);
        database.uid = user?.uid;
        await _updateProfile();
        phoneSignInForm.init();
        emit(AuthLoginSuccessState(user: user, wasLogout: this._wasLogout));
      }
    } on AuthException catch (e) {
      emit(AuthLoginErrorState(e.message));
    }
  }

  void signOut() {
    _authService.signOut();
    phoneSignInForm.init();
    _wasLogout = true;
    emit(AuthLogoutState(phoneSignInForm));
  }
}
