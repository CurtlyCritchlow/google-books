import 'package:google_books/commands/base_command.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// This class is responsible for signing users in.
class SignInCommand extends BaseCommand {
  SignInCommand(BuildContext context) : super(context);

  /// Calls AuthenticationService.signinUserWithEmailAndPassword Method.
  ///
  ///Recieves String email, password and BuildContext context from widget and pass it to the authenticatonService.signinUserWithEmailAndPassword method.
  ///
  /// If method call was successful, return true and flase otherwise.
  Future<bool> run({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    UserCredential? signinUser =
        await authenticationService.signinUserWithEmailAndPassword(
      email: email,
      password: password,
      context: context,
    );

    if (signinUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
