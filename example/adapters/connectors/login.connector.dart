class LoginConnector implements LoginProtocol {
  final JWt jWt;
  const LoginConnector({
    required this.jWt,
  });

}