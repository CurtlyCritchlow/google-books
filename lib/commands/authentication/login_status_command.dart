import 'package:google_books/services/authentication_service.dart';
import 'package:flutter/material.dart';

import '../base_command.dart';

/// This command is responsible for checking the user signin status.
class SigninStatusCommand extends BaseCommand {
  SigninStatusCommand(BuildContext context) : super(context);

  /// Calls AuthenticationService.userAuthStatus Method.
  ///
  /// check user authentication status
  ///
  /// If user is signed in return true and false otherwise.
  bool run() {
    return AuthenticationService().userAuthStatus();
  }
}
