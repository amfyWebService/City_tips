import 'package:city_tips/core/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Tries to sign in a user with the given email address and password.
  ///
  /// If successful, it also signs the user in into the app and updates
  /// the [onAuthStateChanged] stream.
  ///
  /// **Important**: You must enable Email & Password accounts in the Auth
  /// section of the Firebase console before being able to use them.
  ///
  /// Errors:
  ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
  ///   • `ERROR_WRONG_PASSWORD` - If the [password] is wrong.
  ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address, or if the user has been deleted.
  ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
  ///   • `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
  ///   • `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.
  Future<User> authenticate({@required String username, @required String password}) async {
    FirebaseUser firebaseUser = await _auth.signInWithEmailAndPassword(email: username, password: password);
    User user = new User(id: firebaseUser.uid, username: firebaseUser.email, beacons: []);
    return user;
  }

  /// Tries to create a new user account with the given email address and password.
  ///
  /// If successful, it also signs the user in into the app and updates
  /// the [onAuthStateChanged] stream.
  ///
  /// Errors:
  ///   • `ERROR_WEAK_PASSWORD` - If the password is not strong enough.
  ///   • `ERROR_INVALID_CREDENTIAL` - If the email address is malformed.
  ///   • `ERROR_EMAIL_ALREADY_IN_USE` - If the email is already in use by a different account.
  Future<User> createUser({@required String username, @required String password}) async {
    FirebaseUser firebaseUser = await _auth.createUserWithEmailAndPassword(email: username, password: password);
    User user = new User(id: firebaseUser.uid, username: firebaseUser.email, beacons: []);
    return user;
  }

  /// Signs out the current user and clears it from the disk cache.
  ///
  /// If successful, it signs the user out of the app and updates
  /// the [onAuthStateChanged] stream.
  Future<void> signOut() async {
    await _auth.signOut();
    return;
  }

  Future<bool> isSignIn() async {
    return await _auth.currentUser() != null;
  }

  /// Returns the currently signed-in [FirebaseUser] or [null] if there is none.
  Future<User> getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    return new User(id: firebaseUser.uid, username: firebaseUser.email, beacons: []);
  }
}