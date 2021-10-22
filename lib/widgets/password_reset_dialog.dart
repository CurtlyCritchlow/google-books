import 'package:google_books/commands/authentication/password_reset_command.dart';
import 'package:google_books/utils/abstract.dart';
import 'package:google_books/utils/styles.dart';
import 'package:flutter/material.dart';

class PasswordResetDialog extends StatefulWidget {
  static String routeName = 'PasswordResetDialog';
  const PasswordResetDialog({
    Key? key,
  }) : super(key: key);

  @override
  _PasswordResetDialogController createState() =>
      _PasswordResetDialogController();
}

class _PasswordResetDialogController extends State<PasswordResetDialog> {
  @override
  Widget build(BuildContext context) => _PasswordResetDialogView(this);

  String? _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Check if field contains "@" and "." symbol.
  ///
  /// If validation fails show a field cannot be left blank or enter a valid email address error message.
  String? _handleEmailValidation(value) {
    if (value!.isEmpty) {
      return "Field cannot be left blank";
    } else if (!value.contains('@') || !value.contains('.')) {
      return "Enter a valid email address";
    } else {
      return null;
    }
  }

  /// Save user input if validation succeeds.
  void _handleEmailSaved(String? value) {
    _email = value;
  }

  /// Reset user password.
  ///
  /// Reset is achieved by Calling the method to save user input and PasswordResetCommand().run method if validation succeeds.
  void _handleResetButtonOnPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      PasswordResetCommand(context).run(email: _email!, context: context);
    }
  }

  /// Cancels the password reset Alert Dialog.
  ///
  /// Cancellation is achieved by calling the navigator.of(context).pop() method.
  void _handleCancelButtonOnPressed() {
    Navigator.of(context).pop();
  }
}

class _PasswordResetDialogView
    extends WidgetView<PasswordResetDialog, _PasswordResetDialogController> {
  // ignore: annotate_overrides, overridden_fields, prefer_typing_uninitialized_variables
  final state;
  const _PasswordResetDialogView(this.state) : super(state);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reset Password'),
      content: Form(
        key: state._formKey,
        child: TextFormField(
          decoration: FormStyles.textFieldDecoration(labelText: 'Email'),
          validator: state._handleEmailValidation,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          onSaved: state._handleEmailSaved,
        ),
      ),
      actions: [
        TextButton(
            onPressed: state._handleCancelButtonOnPressed,
            child: const Text('Cancel')),
        TextButton(
          onPressed: state._handleResetButtonOnPressed,
          child: const Text('Reset'),
        ),
      ],
    );
  }
}
