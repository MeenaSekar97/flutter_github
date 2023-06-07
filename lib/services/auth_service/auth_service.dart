import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<UserCredential?> signInWithGitHub() async {
    // Create a new provider
    try {
      GithubAuthProvider githubProvider = GithubAuthProvider();

      githubProvider.addScope('repo');

      final res =
          await FirebaseAuth.instance.signInWithProvider(githubProvider);

      print('data$res');

      if (res.user != null) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      print('res$e');
      return null;
    }
  }
}
