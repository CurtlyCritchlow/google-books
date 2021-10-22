import 'package:google_books/commands/authentication/signup_command.dart';
import 'package:google_books/screens/google_books_screens/book_list_screen.dart';

import 'package:google_books/services/service_models/user_service_model.dart';
import 'package:google_books/utils/abstract.dart';
import 'package:google_books/utils/page_routes.dart';
import 'package:google_books/utils/styles.dart';
import 'package:google_books/utils/utils.dart';

import 'package:google_books/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_books/screens/authentication_screens/signin_page.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = 'signUpPage';
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpPageController createState() => _SignUpPageController();
}

class _SignUpPageController extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) => _SignUpPageView(this);
  final _userServiceModel = UserServiceModel.form();
  String? _password;
  bool _formChanged = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final FocusNode userNameFocusNode;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();

    userNameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    userNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  // Form level methods
  void _handleOnFormChanged() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await SignUpCommand(context)
          .run(
              email: _userServiceModel.email,
              password: _password!,
              userServiceModel: _userServiceModel,
              context: context)
          .then((value) {
        if (value) {
          Navigator.of(context).pushReplacement(
              PageRoutes.defaultRoute(() => const BookListScreen()));
        }
      });
    } else {
      SnackBars.errorSnackBar(
          content: 'Only optional fields can be blank.', context: context);
    }
  }

  void _handleSigninNavigation() {
    Navigator.of(context)
        .push(PageRoutes.defaultRoute(() => const SignInPage()));
  }

  void _handlePasswordSaved(String? value) => _password = value;
}

class _SignUpPageView extends WidgetView<SignUpPage, _SignUpPageController> {
  // ignore: annotate_overrides, prefer_typing_uninitialized_variables, overridden_fields
  final state;
  const _SignUpPageView(this.state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Center(child: Text('Google Books')),
            Form(
              key: state._formKey,
              onChanged: state._handleOnFormChanged,
              child: FractionallySizedBox(
                widthFactor:
                    ResponsiveWidget.isMobileScreen(context) ? 0.9 : 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20.0),
                    // Username Text Field
                    TextFormField(
                      decoration:
                          FormStyles.textFieldDecoration(labelText: 'Username'),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      focusNode: state.userNameFocusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: state._userServiceModel.validateRequiredField,
                      onSaved: state._userServiceModel.saveUserName,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20.0),

                    // Email Text Field
                    TextFormField(
                      decoration:
                          FormStyles.textFieldDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      focusNode: state.emailFocusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:
                          state._userServiceModel.validateRequiredEmailField,
                      onSaved: state._userServiceModel.saveEmail,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20.0),

                    // Password Text Field
                    TextFormField(
                      decoration:
                          FormStyles.textFieldDecoration(labelText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      focusNode: state.passwordFocusNode,
                      validator:
                          state._userServiceModel.validateRequiredPasswordField,
                      onSaved: state._handlePasswordSaved,
                    ),
                    const SizedBox(height: 48.0),
                    ElevatedButton(
                      key: const Key('signup-button'),
                      onPressed:
                          state._formChanged ? state._handleSignup : null,
                      child: const Text('Sign Up'),
                    ),
                    TextButton(
                        onPressed: state._handleSigninNavigation,
                        child: const Text("Already have an account? Sign In"))
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
