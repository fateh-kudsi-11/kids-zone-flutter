import 'package:flutter/cupertino.dart';
import 'package:kidszone/Widgets/appearance_popup.dart';
import 'package:kidszone/layouts/account_divider.dart';
import 'package:provider/provider.dart';
import '/providers/auth.dart';
import '/Widgets/my_account_header.dart';
import '/layouts/account_button.dart';
import '/layouts/heading_text.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  Future<void> showDialog() async {
    await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Sign Out'),
        content: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text('Are you sure you want to sign out'),
        ),
        actions: [
          CupertinoButton(
            child: const Text(
              'Yes',
              style: TextStyle(color: CupertinoColors.systemRed),
            ),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.pop(context);
            },
          ),
          CupertinoButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAuth = Provider.of<Auth>(context).isAuth;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
          middle: HeadingText(
        text: 'My Account',
        size: 18,
        letterSpacing: 0.5,
      )),
      child: SafeArea(
        child: isAuth
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    const MyAccountHeader(),
                    AccountButton(
                      title: 'My Orders',
                      icon: 'box',
                      isBorder: false,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/myOrders');
                      },
                    ),
                    const AccountDivider(),
                    AccountButton(
                      title: 'My details',
                      icon: 'detail',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/myDetails');
                      },
                    ),
                    AccountButton(
                      title: 'Change password',
                      icon: 'password',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/changePassword');
                      },
                    ),
                    AccountButton(
                      title: 'Address book',
                      icon: 'address',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/addressBook');
                      },
                    ),
                    AccountButton(
                      title: 'Payment methods',
                      icon: 'payment',
                      isBorder: false,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/paymentMethods');
                      },
                    ),
                    const AccountDivider(),
                    AccountButton(
                      title: 'Notification',
                      icon: 'noti',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/notification');
                      },
                    ),
                    AccountButton(
                      title: 'Appearance',
                      icon: 'appear',
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => const AppearancepopUp());
                      },
                    ),
                    AccountButton(
                      title: 'Rate this app',
                      icon: 'rate',
                      isBorder: false,
                      onPressed: () {},
                    ),
                    const AccountDivider(),
                    AccountButton(
                      title: 'Sign out',
                      icon: 'signout',
                      isBorder: false,
                      onPressed: showDialog,
                    ),
                  ],
                ),
              )
            : const Center(
                child: Text('Please Sign in'),
              ),
      ),
    );
  }
}
