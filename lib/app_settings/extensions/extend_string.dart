extension EmailValidator on String {
  bool isInvalidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return !emailRegex.hasMatch(this);
  }
}