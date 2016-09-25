class GypSyntaxError extends Exception {
  factory GypSyntaxError(String message) => new _GypSyntaxErrorImpl(message);
}

class _GypSyntaxErrorImpl implements GypSyntaxError {
  final String message;

  _GypSyntaxErrorImpl(this.message);

  @override
  String toString() => 'Unexpected syntax error: $message';

}
