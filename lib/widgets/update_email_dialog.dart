import 'package:google_books/commands/authentication/update_email_command.dart';
import 'package:google_books/utils/abstract.dart';
import 'package:google_books/utils/styles.dart';
import 'package:flutter/material.dart';

class UpdateEmailDialog extends StatefulWidget {
  static String routeName = 'UpdateEmailDialog';
  const UpdateEmailDialog({
    Key? key,
  }) : super(key: key);

  @override
  _UpdateEmailDialogController createState() => _UpdateEmailDialogController();
}

class _UpdateEmailDialogController extends State<UpdateEmailDialog> {
  @override
  Widget build(BuildContext context) => _UpdateEmailDialogView(this);

  String? _newEmail;
  String? _password;
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

  /// Save user email if validation succeeds.
  void _handleEmailSaved(String? value) {
    _newEmail = value;
  }

  /// If validation fails show a field cannot be left blank or enter a valid email address error message.
  ///
  String? _handlePasswordValidation(value) {
    if (value!.length < 5) {
      return 'Password too short';
    } else {
      return null;
    }
  }

  /// Save user password if validation succeeds.
  ///
  void _handlePasswordSaved(String? value) {
    _password = value;
  }

  /// Reset user email.
  ///
  /// Reset is achieved by Calling the method to save user input and PasswordResetCommand().run method if validation succeeds.
  void _handleUpdateButtonOnPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UpdateEmailCommand(context)
          .run(newEmail: _newEmail!, password: _password!, context: context);
    }
  }

  /// Cancels the password reset Alert Dialog.
  ///
  /// Cancellation is achieved by calling the navigator.of(context).pop() method.
  void _handleCancelButtonOnPressed() {
    Navigator.of(context).pop();
  }
}

class _UpdateEmailDialogView
    extends WidgetView<UpdateEmailDialog, _UpdateEmailDialogController> {
  // ignore: annotate_overrides, overridden_fields, prefer_typing_uninitialized_variables
  final state;
  const _UpdateEmailDialogView(this.state) : super(state);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Email'),
      content: Form(
        key: state._formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration:
                  FormStyles.textFieldDecoration(labelText: 'New Email'),
              validator: state._handleEmailValidation,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              onSaved: state._handleEmailSaved,
            ),
            TextFormField(
              decoration:
                  FormStyles.textFieldDecoration(labelText: 'Current Password'),
              validator: state._handlePasswordValidation,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
              onSaved: state._handlePasswordSaved,
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: state._handleCancelButtonOnPressed,
            child: const Text('Cancel')),
        TextButton(
          onPressed: state._handleUpdateButtonOnPressed,
          child: const Text('Update'),
        ),
      ],
    );
  }
}

// class PasswordResetDialog extends StatelessWidget {
//   static String routeName = 'PasswordResetDialog';

//   @override
//   Widget build(BuildContext context) => _PasswordResetDialogView(this);

//   String? _email;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   PasswordResetDialog({
//     Key? key,
//   }) : super(key: key);

//   String? _handleEmailValidation(value) {
//     if (value!.isEmpty) {
//       return "Field cannot be left blank";
//     } else if (!value.contains('@') || !value.contains('.')) {
//       return "Enter a valid email address";
//     } else
//       return null;
//   }

//   void _handleEmailSaved(String? value) {
//     _email = value;
//   }

//   void _handleResetButtonOnPressed(BuildContext context) {
//     print('command run');
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       PasswordResetCommand().run(email: _email!, context: context);

//       // Navigator.of(context).push(PageRoutes.defaultRoute(() => LoginPage()));
//     }
//   }
// }

// class _PasswordResetDialogView extends StatelessView<PasswordResetDialog> {
//   final widget;
//   const _PasswordResetDialogView(this.widget) : super(widget);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Reset Password'),
//       content: TextFormField(
//         decoration: FormStyles.textFieldDecoration(labelText: 'Email'),
//         validator: widget._handleEmailValidation,
//         onSaved: widget._handleEmailSaved,
//       ),
//       actions: [
//         TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel')),
//         TextButton(
//           onPressed: () {
//             widget._handleResetButtonOnPressed(context);
//           },
//           child: Text('Reset'),
//         ),
//       ],
//     );
//   }
// }
