class EmailValidator {
  static final EmailValidator _singleton = EmailValidator._internal();

  factory EmailValidator() {
    return _singleton;
  }

  EmailValidator._internal();

  static String? validate(String? email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (email == null || email.isEmpty) {
      return 'O e-mail é obrigatório';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Esse não é um e-mail valido';
    } else if (email.length > 200) {
      return 'Esse e-mail é muito longo';
    }

    return null;
  }
}
