import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:string_validator/string_validator.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/providers/stage.dart';
import '/providers/auth.dart';
import '/layouts/action_button.dart';
import '/layouts/secondary_button.dart';
import '/layouts/ios_Text_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final form = GlobalKey<FormState>();

  final paswordFocusNode = FocusNode();

  final nameFoucsNode = FocusNode();

  final lastNameFoucsNode = FocusNode();

  final confirmPasswordFoucsNode = FocusNode();

  final emailControler = TextEditingController();

  final emailFoucsNode = FocusNode();

  final passwordController = TextEditingController();

  bool _loading = false;

  final values = {
    'email': '',
    'firstName': '',
    'lastName': '',
    'password': '',
    'confirmPassword': ''
  };

  Future<void> showErrorDialog(String errorMsg) async {
    await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Signup Field'),
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

  Future<void> _savedForm() async {
    if (!(form.currentState?.validate() as bool)) return;
    form.currentState?.save();
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .signup(values['email'] as String, values['firstName'] as String,
              values['lastName'] as String, values['password'] as String)
          .then((value) {
        Flushbar(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          title: 'Signup Success',
          message: 'Thank you! We are happy to have you on board.',
          titleColor:
              themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
          backgroundColor:
              themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
          messageColor:
              themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
          duration: const Duration(seconds: 5),
        ).show(context);

        Provider.of<StageManger>(context, listen: false).setStage('app');
      });
    } on HttpException catch (error) {
      if (error.toString().contains('Duplicate field value entered')) {
        showErrorDialog('This email addrees is alreay on use').then((value) {
          emailControler.clear();
          FocusScope.of(context).requestFocus(emailFoucsNode);
        });
      }
      setState(() {
        _loading = false;
      });
    } catch (error) {
      setState(() {
        _loading = false;
      });

      showErrorDialog('Some Thing Went Wrong Please Try Agien Later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: form,
            child: Column(
              children: [
                IOSTextInput(
                  keyboardType: TextInputType.emailAddress,
                  placeholder: "Please Enter Your Email Address",
                  title: "Email Address:",
                  controler: emailControler,
                  focusNode: emailFoucsNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(nameFoucsNode);
                  },
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
                  keyboardType: TextInputType.name,
                  placeholder: "Please Enter Your First Name",
                  focusNode: nameFoucsNode,
                  title: "First Name:",
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(lastNameFoucsNode);
                  },
                  validator: (String? value) {
                    if (!isLength(value!, 1)) {
                      return 'Please Enter a Your First Name';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    values['firstName'] = value as String;
                  },
                ),
                IOSTextInput(
                  keyboardType: TextInputType.name,
                  placeholder: "Please Enter Your Last Name",
                  focusNode: lastNameFoucsNode,
                  title: "Last Name:",
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(paswordFocusNode);
                  },
                  validator: (String? value) {
                    if (!isLength(value!, 1)) {
                      return 'Please Enter a Your Last Name';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    values['lastName'] = value as String;
                  },
                ),
                IOSTextInput(
                  keyboardType: TextInputType.visiblePassword,
                  placeholder: "Please Enter Your Password",
                  textInputAction: TextInputAction.next,
                  title: "Password:",
                  isPassword: true,
                  focusNode: paswordFocusNode,
                  controler: passwordController,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(confirmPasswordFoucsNode),
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
                IOSTextInput(
                  keyboardType: TextInputType.visiblePassword,
                  placeholder: "Please Confirm Your Password",
                  textInputAction: TextInputAction.go,
                  title: "Confirm Password:",
                  isPassword: true,
                  focusNode: confirmPasswordFoucsNode,
                  onFieldSubmitted: (_) {
                    _savedForm();
                  },
                  validator: (String? value) {
                    if (!isLength(value!, 6)) {
                      return 'Please Confirm Your Password';
                    } else if (value != passwordController.text) {
                      return 'Passwords Do Not Match!';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    values['confirmPassword'] = value as String;
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
                      title: 'JOIN',
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
          )
        ],
      ),
    );
  }
}
