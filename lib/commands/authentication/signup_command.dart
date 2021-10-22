import 'package:google_books/services/service_models/user_service_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../base_command.dart';

/// This class is responsible for signing up a user.
class SignUpCommand extends BaseCommand {
  SignUpCommand(BuildContext c) : super(c);

  /// Calls AuthenticationService signupUserWithEmailAndPassword Method.
  ///
  ///Recieves user data and BuildContext context from widget and pass it to the authenticatonService.signupUserWithEmailAndPassword method.
  ///
  /// If method call was successful, return true and false otherwise.
  Future<bool> run({
    required UserServiceModel userServiceModel,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    bool signUpSuccess;
    // todo: send user data to Authenticationservices to signup user
    User? createdUser =
        await authenticationService.signupUserWithEmailAndPassword(
            email: email, password: password, context: context);

    // todo: send usermodel data to Users collection to complete sign up
    if (createdUser != null) {
      userService.addUser(
        id: createdUser.uid,
        userServiceModel: userServiceModel,
        context: context,
      );
      signUpSuccess = true;
    } else {
      signUpSuccess = false;
    }
    return signUpSuccess;

    // todo: recieve user data from services to send to Usermodel
  }
}
