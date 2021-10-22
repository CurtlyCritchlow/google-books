import 'package:google_books/commands/base_command.dart';
import 'package:flutter/material.dart';

/// This class is responsible for password reset.
class PasswordResetCommand extends BaseCommand {
  PasswordResetCommand(BuildContext c) : super(c);

  /// Calls AuthenticationService sendPasswordResertEmail Method.
  ///
  ///Recieves String email and BuildContext context from widget and pass it to the authenticatonService.sendPasswordResetEmail method.
  ///
  /// If method call was successful, show Dialog informing the user that the password link was sent to their email.
  Future<void> run({
    required String email,
    required BuildContext context,
  }) async {
    await authenticationService
        .sendPasswordResetEmail(email: email, context: context)
        .then((value) {
      if (value) {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Password Reset',
                  textAlign: TextAlign.center,
                ),
                content:
                    const Text('Check your email for password reset link.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Ok'),
                  )
                ],
              );
            });
      }
    });
  }
}
