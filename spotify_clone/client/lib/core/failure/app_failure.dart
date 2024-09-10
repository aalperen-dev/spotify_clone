class AppFailureMsg {
  final String message;

  AppFailureMsg([this.message = 'Sorry, an unexpected error occurred!']);

  @override
  String toString() => 'AppFailureMsg(message: $message)';
}
