import 'package:google_books/commands/base_command.dart';
import 'package:flutter/material.dart';

/// This class is responsible for email update.
class UpdateEmailCommand extends BaseCommand {
  UpdateEmailCommand(BuildContext c) : super(c);

  /// Calls AuthenticationService updateEmail Method.
  ///
  ///Recieves String email, password and BuildContext context from widget and pass it to the authenticatonService.updateEmail method.
  ///
  /// If method call was successful, show Dialog informing the user that the Email update was sucessful.
  Future<void> run({
    required String newEmail,
    required String password,
    required BuildContext context,
  }) async {
    await authenticationService
        .updateEmail(newEmail: newEmail, password: password, context: context)
        .then((value) {
      if (value) {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Email Success',
                  textAlign: TextAlign.center,
                ),
                content: const Text('Your email was successfully changed'),
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
