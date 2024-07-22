class ErrorsConsts {
  static final ErrorsConsts _singleton = ErrorsConsts._internal();

  factory ErrorsConsts() {
    return _singleton;
  }

  ErrorsConsts._internal();

  static const API_DEFAULT_ERROR =
      'Algo deu errado. Por favor, tente novamente mais tarde.';
}
