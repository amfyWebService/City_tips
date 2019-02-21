import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> authenticate({
    @required String username,
    @required String password,
  }) async {

    final FirebaseUser user = await _auth.signInWithEmailAndPassword(email: username, password: password);
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    return;
  }

  Future<bool> isSignIn() async {
    return await _auth.currentUser() != null;
  }

  /// {inheritDoc}
  Future<FirebaseUser> getUser() async {
    return _auth.currentUser();
  }
}