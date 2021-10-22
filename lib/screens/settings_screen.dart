import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_books/commands/authentication/signout_command.dart';
import 'package:google_books/screens/authentication_screens/signin_page.dart';
import 'package:google_books/utils/abstract.dart';
import 'package:google_books/utils/page_routes.dart';
import 'package:google_books/widgets/app_bottom_navigation_bar.dart';
import 'package:google_books/widgets/update_email_dialog.dart';
import 'package:google_books/widgets/update_password_dialog.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = 'SettingsScreen';
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _SettingsScreenView(this);
  void _handleUpdatePassword(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const UpdatePasswordDialog();
        });
  }

  void _handleUpdateEmail(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const UpdateEmailDialog();
        });
  }

  void _handleSignOut(BuildContext context) {
    SignoutCommand(context).run();
    Navigator.of(context)
        .push(PageRoutes.defaultRoute(() => const SignInPage()));
  }
}

class _SettingsScreenView extends StatelessView<SettingsScreen> {
  // ignore: annotate_overrides, prefer_typing_uninitialized_variables, overridden_fields
  final widget;
  const _SettingsScreenView(this.widget) : super(widget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            // SettingsItem(
            //   iconData: Icons.verified_user_rounded,
            //   title: context.watch<User?>()!.email!,
            //   onTap: () {},
            // ),
            SettingsItem(
              iconData: Icons.email,
              title: 'Change Email',
              onTap: () {
                widget._handleUpdateEmail(context);
              },
            ),
            SettingsItem(
              iconData: Icons.password,
              title: 'Change Password',
              onTap: () {
                widget._handleUpdatePassword(context);
              },
            ),
            SettingsItem(
              iconData: Icons.logout,
              title: 'Sign Out',
              onTap: () => widget._handleSignOut(context),
            )
          ],
        ),
      ),
      bottomNavigationBar: kIsWeb
          ? null
          : const AppButtomNavigationBar(
              selectedIndex: 2,
            ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;

  const SettingsItem({
    required this.iconData,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(iconData),
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right,
      ),
      onTap: () => onTap(),
    );
  }
}
