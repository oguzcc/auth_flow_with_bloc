import '../util/constants.dart';

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    await Future.delayed(duration2);
    throw Exception('failed');
  }

  Future<String> login() async {
    await Future.delayed(duration2);
    return '';
  }

  Future<String> signUp() async {
    await Future.delayed(duration2);
    return '';
  }

  Future<String> confirmation() async {
    await Future.delayed(duration2);
    return 'user';
  }

  Future<void> signOut() async {
    await Future.delayed(duration2);
  }
}
