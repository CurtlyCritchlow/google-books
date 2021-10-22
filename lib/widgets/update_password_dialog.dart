import 'package:google_books/commands/authentication/update_password_command.dart';
import 'package:google_books/utils/abstract.dart';
import 'package:google_books/utils/styles.dart';
import 'package:flutter/material.dart';

class UpdatePasswordDialog extends StatefulWidget {
  static String routeName = 'UpdatePasswordDialog';
  const UpdatePasswordDialog({
    Key? key,
  }) : super(key: key);

  @override
  _UpdatePasswordDialogController createState() =>
      _UpdatePasswordDialogController();
}

class _UpdatePasswordDialogController extends State<UpdatePasswordDialog> {
  @override
  Widget build(BuildContext context) => _UpdatePasswordDialogView(this);

  String? _newPassword;
  String? _oldPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Save user password if validation succeeds.
  void _handleNewPasswordSaved(String? value) {
    _newPassword = value;
  }

  /// If validation fails show a field cannot be left blank or enter a valid email address error message.
  ///
  String? _handlePasswordValidation(value) {
    if (value!.isEmpty) {
      return "Field cannot be left blank";
    } else if (value!.length < 5) {
      return 'Password too short';
    } else {
      return null;
    }
  }

  /// Save user password if validation succeeds.
  ///
  void _handleOldPasswordSaved(String? value) {
    _oldPassword = value;
  }

  /// Reset user password.
  ///
  /// Reset is achieved by Calling the method to save user input and PasswordResetCommand().run method if validation succeeds.
  void _handleUpdateButtonOnPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UpdatePasswordCommand(context).run(
          newPassword: _newPassword!,
          oldPassword: _oldPassword!,
          context: context);
    }
  }

  /// Cancels the password reset Alert Dialog.
  ///
  /// Cancellation is achieved by calling the navigator.of(context).pop() method.
  void _handleCancelButtonOnPressed() {
    Navigator.of(context).pop();
  }
}

class _UpdatePasswordDialogView
    extends WidgetView<UpdatePasswordDialog, _UpdatePasswordDialogController> {
  // ignore: annotate_overrides, overridden_fields, prefer_typing_uninitialized_variables
  final state;
  const _UpdatePasswordDialogView(this.state) : super(state);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Password'),
      content: Form(
        key: state._formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration:
                  FormStyles.textFieldDecoration(labelText: 'Old Password'),
              validator: state._handlePasswordValidation,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              onSaved: state._handleOldPasswordSaved,
            ),
            TextFormField(
              decoration:
                  FormStyles.textFieldDecoration(labelText: 'New Password'),
              validator: state._handlePasswordValidation,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onSaved: state._handleNewPasswordSaved,
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
