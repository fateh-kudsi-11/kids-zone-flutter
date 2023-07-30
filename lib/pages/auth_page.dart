import 'package:flutter/cupertino.dart';
import 'package:kidszone/Widgets/auth_selector.dart';
import 'package:kidszone/Widgets/signup.dart';
import 'package:provider/provider.dart';
import '/providers/stage.dart';
import '/Widgets/signin.dart';
import '/layouts/logo.dart';

enum AuthStage { signin, signup }

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthStage authStage = AuthStage.signin;

  void setAuthStage(AuthStage stage) {
    setState(() {
      authStage = stage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              CupertinoIcons.clear_thick,
              size: 28,
              color: Color(0xff757575),
            ),
            onPressed: () {
              Provider.of<StageManger>(context, listen: false).setStage('app');
            },
          ),
          middle: const Logo(
            height: 24,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AuthSelector(
                authStage: authStage,
                setAuthStage: setAuthStage,
              ),
              authStage == AuthStage.signin ? const SignIn() : const SignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
