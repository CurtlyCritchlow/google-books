import 'package:google_books/commands/authentication/signin_command.dart';
import 'package:google_books/screens/google_books_screens/book_list_screen.dart';
import 'package:google_books/services/authentication_service.dart';

import 'package:google_books/utils/abstract.dart';
import 'package:google_books/utils/page_routes.dart';
import 'package:google_books/utils/styles.dart';

import 'package:google_books/screens/authentication_screens/signup_page.dart';
import 'package:google_books/utils/utils.dart';

import 'package:google_books/widgets/snackbars.dart';
import 'package:google_books/widgets/password_reset_dialog.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

// import 'signup_page.dart';x

class SignInScreen extends StatefulWidget {
  static String routeName = 'signInPage';
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignInPageController createState() => _SignInPageController();
}

class _SignInPageController extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) => _SignInPageView(this);

  String? _email;
  String? _password;
  bool _formChanged = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    // Create focusNode
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    //Dispose focusNode
    focusNode!.dispose();
    super.dispose();
  }

// Disable Signin button if use doesn't start filling out form
  void _handleOnFormChanged() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }

  // Show error if email doesn't contain @ and . or is empty.
  String? _handleEmailValidation(String? value) {
    if (value!.isEmpty) {
      return "Field cannot be left blank";
    } else if (!value.contains('@') || !value.contains('.')) {
      return "Enter a valid email address";
    } else {
      return null;
    }
  }

// Save value from email field to _email variable
  void _handleEmailSaved(String? value) {
    _email = value;
  }

// Show error message if password doesn't meet firebase password requirement
  String? _handlePasswordValidation(value) {
    if (value!.isEmpty) {
      return "Field cannot be left blank";
    } else if (value!.length < 5) {
      return 'Password too short';
    } else {
      return null;
    }
  }

// Save value from password field to _password variable
  void _handlePasswordSaved(String? value) {
    _password = value;
  }

// Sign user in and redirect to BookListScreen()
  void _handleSignin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await SignInCommand(context)
          .run(
        email: _email!,
        password: _password!,
        context: context,
      )
          .then(
        (value) async {
          if (value) {
            Navigator.of(context).push(
              PageRoutes.defaultRoute(() {
                return const BookListScreen();
              }),
            );
          }
        },
      );
    } else {
      FocusScope.of(context).requestFocus(focusNode);
      SnackBars.errorSnackBar(content: 'Error on form', context: context);
    }
  }

  void _handleSignUpNavigation() {
    Navigator.of(context).push(
      PageRoutes.sharedAxis(() => const SignUpPage()),
    );
  }

  void _handleForgetPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return const PasswordResetDialog();
        });
  }

  void _handleSignInWithGoogle() async {
    await AuthenticationService().signInWithGoogle();
    Navigator.of(context)
        .push(PageRoutes.sharedAxis(() => const BookListScreen()));
  }
}

class _SignInPageView extends WidgetView<SignInScreen, _SignInPageController> {
  // ignore: annotate_overrides, prefer_typing_uninitialized_variables, overridden_fields
  final state;
  const _SignInPageView(this.state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const Center(
                child: Text('Google Books'),
              ),
              FractionallySizedBox(
                widthFactor:
                    ResponsiveWidget.isMobileScreen(context) ? 0.9 : 0.7,
                child: Form(
                  key: state._formKey,
                  onChanged: state._handleOnFormChanged,
                  // onWillPop: state._handleOnFormWillPop,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Email Text Field
                        TextFormField(
                          decoration: FormStyles.textFieldDecoration(
                              labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: state._handleEmailValidation,
                          onSaved: state._handleEmailSaved,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20.0),
                        // Password Text Field
                        TextFormField(
                          decoration: FormStyles.textFieldDecoration(
                              labelText: 'Password'),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          focusNode: state.focusNode,
                          validator: state._handlePasswordValidation,
                          onSaved: state._handlePasswordSaved,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 48.0),
                        ElevatedButton(
                          onPressed:
                              state._formChanged ? state._handleSignin : null,
                          child: const Text('Sign In'),
                        ),
                        TextButton(
                          onPressed: state._handleForgetPassword,
                          child: const Text('Forgot Password?'),
                        ),
                        TextButton(
                            onPressed: state._handleSignUpNavigation,
                            child:
                                const Text("Don't have an account? Sign Up")),

                        TextButton.icon(
                          onPressed: state._handleSignInWithGoogle,
                          icon: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              'assets/images/google_g_icon.png',
                            ),
                          ),
                          label: const Text('Sign In with Google'),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
