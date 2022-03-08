class UiMessages {
  static const String noAddresses = "Add your first address!";
}

//todo: put inside ui m,essage class?
class ErrorMessages {
  static const String errorGeneric = "Sorry, something went wrong";
  static const String failedToLoad =
      "Couldn't load data from the server. Please try again";
  static const String signInError = "Couldn't sign you in. Please try again";
  static const String failedToLoadPullToRefresh =
      "Failed to load data from the server. Pull down to refresh";
  static const String noDataPullToRefresh = "No data. Pull down to refresh";

  static const ValidationErrorMessages validationErrorMessages =
      ValidationErrorMessages();
}

class ValidationErrorMessages {
  const ValidationErrorMessages();

  final String emptyField = "This field cannot be empty";
  final String forbiddenSymbols = "Forbidden symbols";
  final String incorrectEmail = "Incorrect email format";
  final String futureDate = "Date cannot be in the future";
  final String incorrectPhone = "Incorrect phone number format";

//todo: static func to make a string like 'Name cannto be empty'
}
