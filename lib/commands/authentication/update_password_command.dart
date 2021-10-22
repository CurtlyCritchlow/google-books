import 'package:google_books/commands/base_command.dart';
import 'package:flutter/material.dart';

/// This class is responsible for password update.
class UpdatePasswordCommand extends BaseCommand {
  UpdatePasswordCommand(BuildContext c) : super(c);

  /// Calls AuthenticationService updatePassword Method.
  ///
  ///Recieves String email, Oldpassword, newPassword and BuildContext context from widget and pass it to the authenticatonService.updatepassword method.
  ///
  /// If method call was successful, show Dialog informing the user that the Password update was sucessful.
  Future<void> run({
    required String newPassword,
    required String oldPassword,
    required BuildContext context,
  }) async {
    await authenticationService
        .updatePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
            context: context)
        .then((value) {
      if (value) {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Password Success',
                  textAlign: TextAlign.center,
                ),
                content: const Text('Your password was successfully changed'),
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
