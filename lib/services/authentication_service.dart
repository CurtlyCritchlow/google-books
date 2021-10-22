import 'package:google_books/utils/utils.dart';
import 'package:google_books/widgets/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

/// This class is responsible for making Authentication calls to FirebaseAuth.instance.
class AuthenticationService {
  final FirebaseAuth _auth;

  AuthenticationService() : _auth = FirebaseAuth.instance;
  // AuthenticationService.test() : this._auth = MockFirebaseAuth();

  bool userAuthStatus() {
    bool state = false;
    // _auth.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     state = true;
    //   } else
    //     state = false;
    // });

    if (_auth.currentUser == null) {
      state = false;
    } else {
      state = true;
    }
    return state;
  }

  /// Get current user.
  ///
  /// This method should only be called if a user is currently signed in.
  Stream<User?> authUser() {
    // User? currentUser;
    // print(_auth.currentUser!.email);
    // print(userAuthStatus());
    // _auth.authStateChanges().listen((User? user) {
    //   currentUser = user!;
    // });
    return _auth.authStateChanges();
    // return currentUser!;
  }

  /// Calls FirebaseAuth signout method.
  void signoutUser() {
    _auth.signOut();
  }

  /// Signs user in using Google Sign in
  ///
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Calls FirebaseAuth signInWithEmailAndPassword Method.
  ///
  ///Returns UserCredential if passwordResetEmail was sent successfully and null otherwise.
  ///
  /// Throws an snackbar Error message if 'user-not-found', 'wrong-password', 'user-disabled, and 'invalid-email' FirebaseAuthException is raised
  Future<UserCredential?> signinUserWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    // check for internet access before  signing user in
    late bool internetAvailability;

    try {
      internetAvailability = await Utils.isInternetAvailable();
    } on UnsupportedError catch (_) {
      // using web so internet is available

      internetAvailability = true;
    }
    if (internetAvailability) {
      try {
        // Sign user in
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          SnackBars.errorSnackBar(
              content: "No user found for with this email", context: context);
        } else if (e.code == 'invalid-email') {
          SnackBars.errorSnackBar(
              content: 'Invalid email address', context: context);
        } else if (e.code == 'wrong-password') {
          SnackBars.errorSnackBar(
              content: 'Wrong password provided for this user',
              context: context);
        } else if (e.code == 'user-disabled') {
          SnackBars.errorSnackBar(
              content: 'This account has been disabled', context: context);
        }
      }
    } else {
      // Display snackbar error if device is not connected to the internet
      SnackBars.errorSnackBar(
          content: 'Check your internet connection', context: context);
    }
  }

  /// Calls FirebaseAuth createUserWithEmailAndPassword Method.
  ///
  /// Returns User if user account was successfully created and null otherwise.
  ///
  /// Throws an snackbar Error message if 'weak-password', 'email-already-in-use' or 'invalid-email' FirebaseAuthException is raised
  ///
  /// Throws asnackBar Error is internet accecc not available
  Future<User?> signupUserWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (await Utils.isInternetAvailable()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          SnackBars.errorSnackBar(
              content: 'The password provided is too weak.', context: context);
        } else if (e.code == 'email-already-in-use') {
          SnackBars.errorSnackBar(
              content: "An account already exists for this email.",
              context: context);
        } else if (e.code == 'invalid-email') {
          SnackBars.errorSnackBar(
              content: "Please use a valid email.", context: context);
        }
      }
    } else {
      SnackBars.errorSnackBar(
          content: 'Check your internet connection', context: context);
    }
  }

  /// Send verification email.
  ///
  ///
  Future sendEmailVerification() async {
    if (_auth.currentUser!.emailVerified) {
      await _auth.currentUser!.sendEmailVerification();
    }
  }

  /// Calls FirebaseAuth sendPasswordResertEmail Method.
  ///
  ///Returns true if passwordResetEmail was sent successfully and false otherwise.
  ///
  /// Throws an snackbar Error message if 'user-not-found', or 'invalid-email' FirebaseAuthException is raised
  Future<bool> sendPasswordResetEmail({
    required String email,
    required BuildContext context,
  }) async {
    bool success = false;
    if (await Utils.isInternetAvailable()) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        success = true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          SnackBars.errorSnackBar(
              content:
                  'There is no user record corresponding to this email. The user may have been deleted.',
              context: context);
        } else if (e.code == 'invalid-email') {
          Navigator.of(context).pop();
          SnackBars.errorSnackBar(
              content: 'Please use a valid email', context: context);
        } else {
          SnackBars.errorSnackBar(content: e.code, context: context);
        }
      }
    } else {
      SnackBars.errorSnackBar(
          content: 'Check your internet connection', context: context);
    }
    return success;
  }

  /// Calls FirebaseAuth.currentUser.reauthenticateWithCredential().
  ///
  /// If sucessful return true and false otherwise.
  Future<bool> reauthenticateUser({
    required String password,
    required BuildContext context,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!, password: password);
    try {
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-mismatch') {
        SnackBars.errorSnackBar(content: 'User mismatch', context: context);
      } else if (e.code == 'user-not-found') {
        SnackBars.errorSnackBar(
            content: 'User account not found', context: context);
      } else if (e.code == 'invalid-credential') {
        SnackBars.errorSnackBar(
            content: 'Invalid Credential', context: context);
      } else if (e.code == 'invalid-email') {
        SnackBars.errorSnackBar(content: 'Invalid Email', context: context);
      } else if (e.code == 'wrong-password') {
        SnackBars.errorSnackBar(content: 'Wrong password', context: context);
      } else if (e.code == 'invalid-verification-code') {
        SnackBars.errorSnackBar(
            content: 'Invalid Verification Code', context: context);
      } else if (e.code == 'invalid-verification-id') {
        SnackBars.errorSnackBar(
            content: 'Invalid Verification Id', context: context);
      }
      return false;
    }
  }

  /// Calls FirebaseAuth.currentuser.updatePassword method.
  ///
  /// Reauthenticate user and then update password
  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    bool success =
        await reauthenticateUser(password: oldPassword, context: context);
    if (success) {
      try {
        await _auth.currentUser!.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        success = false;
        if (e.code == 'weak-password') {
          SnackBars.errorSnackBar(
              content: 'Password too weak', context: context);
        } else if (e.code == 'requires-recent-login') {
          SnackBars.errorSnackBar(
              content: 'Login again, then retry password change',
              context: context);
        }
      }
    }
    return success;
  }

  Future<bool> updateEmail({
    required String newEmail,
    required String password,
    required BuildContext context,
  }) async {
    bool success =
        await reauthenticateUser(password: password, context: context);

    if (success) {
      try {
        await _auth.currentUser!.updateEmail(newEmail);
      } on FirebaseAuthException catch (e) {
        success = false;
        if (e.code == 'invalid-email') {
          SnackBars.errorSnackBar(content: 'Invalid email', context: context);
        } else if (e.code == 'email-already-in-use') {
          SnackBars.errorSnackBar(
              content: 'Email Already In Use', context: context);
        } else if (e.code == 'requires-recent-login') {
          SnackBars.errorSnackBar(
              content: 'Login again, then apply password change',
              context: context);
        }
      }
    }
    return success;
  }
}
