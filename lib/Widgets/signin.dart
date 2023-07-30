import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:string_validator/string_validator.dart';
import 'package:provider/provider.dart';
import '/providers/stage.dart';
import '/providers/theme.dart';
import '/providers/auth.dart';
import '/layouts/action_button.dart';
import '/layouts/secondary_button.dart';
import '/layouts/ios_Text_input.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final form = GlobalKey<FormState>();

  final paswordFocusNode = FocusNode();

  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  bool _loading = false;

  final values = {'email': '', 'password': ''};

  Future<void> showErrorDialog(String errorMsg, String errorTitle) async {
    await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(errorTitle),
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(errorMsg),
        ),
        actions: [
          CupertinoButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> showSuccessMessage() async {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    Flushbar(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      title: 'Signin Success',
      message: 'Welcome Back',
      titleColor: themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
      backgroundColor:
          themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
      messageColor:
          themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
      duration: const Duration(seconds: 5),
    ).show(context);

    Provider.of<StageManger>(context, listen: false).setStage('app');
  }

  Future<void> _savedForm() async {
    if (!(form.currentState?.validate() as bool)) return;
    form.currentState?.save();

    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .signin(values['email'] as String, values['password'] as String);
      await showSuccessMessage();
    } on HttpException catch (error) {
      if (error.toString().contains('Invalid credentails')) {
        showErrorDialog(
            'Please check your email or your password', 'Invalid credentails');
        emailControler.clear();
        passwordControler.clear();
      }
      setState(() {
        _loading = false;
      });
    } catch (error) {
      setState(() {
        _loading = false;
      });

      showErrorDialog("Please Try agine later",
          'Some Thing Went Wrong Please Try Agien Later.');
    }
  }
// @override
//   void dispose() {

//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: form,
          child: Column(
            children: [
              IOSTextInput(
                keyboardType: TextInputType.emailAddress,
                placeholder: "Please Enter Your Email Address",
                title: "EMAIL ADDRESS:",
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(paswordFocusNode);
                },
                controler: emailControler,
                validator: (String? value) {
                  if (!isEmail(value!)) {
                    return 'Please Enter a Vaild Email Address.';
                  }

                  return null;
                },
                onSaved: (value) {
                  values['email'] = value as String;
                },
              ),
              IOSTextInput(
                keyboardType: TextInputType.visiblePassword,
                placeholder: "Please Enter Your Password",
                textInputAction: TextInputAction.go,
                controler: passwordControler,
                title: "PASSWORD:",
                isPassword: true,
                focusNode: paswordFocusNode,
                onFieldSubmitted: (_) => _savedForm(),
                validator: (String? value) {
                  if (!isLength(value!, 6)) {
                    return 'Please Enter a Vaild Password';
                  }

                  return null;
                },
                onSaved: (value) {
                  values['password'] = value as String;
                },
              ),
            ],
          ),
        ),
        Column(
          children: _loading
              ? const [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CupertinoActivityIndicator(
                      radius: 25,
                    ),
                  )
                ]
              : [
                  ActionButton(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    title: 'SIGN IN',
                    width: double.infinity,
                    onPressed: _savedForm,
                  ),
                  SecondaryButton(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    title: 'MAYBE LATER',
                    width: double.infinity,
                    onPressed: () {
                      Provider.of<StageManger>(context, listen: false)
                          .setStage('app');
                    },
                  )
                ],
        ),
      ],
    );
  }
}
