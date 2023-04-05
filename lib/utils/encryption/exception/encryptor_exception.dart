class EncryptorException implements Exception {
  String _message;

  EncryptorException(this._message);

  String error() => _message;
}
