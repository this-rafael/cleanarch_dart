class LogoutConnector implements LogoutProtocol {
  final JWt jWt;
  const LogoutConnector({
    required this.jWt,
  });

}