class AuthCredentials {
  final String username;
  final String? email;
  final String? password;
  final String? userId;

  AuthCredentials({
    required this.username,
    this.email,
    this.password,
    this.userId,
  });
}
