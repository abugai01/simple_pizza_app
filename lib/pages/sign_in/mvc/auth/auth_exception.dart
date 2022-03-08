class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  AuthException.fromCode(String code) : message = getMessageByCode(code);

  //todo: translate, link to where this is taken from
  static String getMessageByCode(String code) {
    switch (code) {
      case 'captcha-check-failed':
        return 'CAPTCHA check failed';
      case 'invalid-phone-number':
        return 'Invalid phone number';
      case 'missing-phone-number':
        return 'Missing phone number';
      case 'quota-exceeded':
        return 'SMS quota exceeded';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Wrong password';
      case 'invalid-credential':
        return 'Invalid credentials';
      case 'invalid-verification-code':
        return 'Wrong verification code';
      case 'session-expired':
        return 'Verification code has expired';
      default:
        return code;
    }
  }
}
