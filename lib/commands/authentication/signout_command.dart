import 'package:google_books/services/authentication_service.dart';
import 'package:flutter/material.dart';

import '../base_command.dart';

/// This class is responsible for signing user out.
class SignoutCommand extends BaseCommand {
  SignoutCommand(BuildContext c) : super(c);

  /// Calls AuthenticationService signoutUser Method.
  void run() {
    AuthenticationService().signoutUser();
  }
}
