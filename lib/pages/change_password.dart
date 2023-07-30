import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:kidszone/layouts/action_button.dart';
import 'package:string_validator/string_validator.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import '/providers/theme.dart';
import '/providers/auth.dart';
import '/layouts/heading_text.dart';
import '/layouts/ios_Text_input.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final form = GlobalKey<FormState>();
  final emailControler = TextEditingController();
  final newPasswordFocusNode = FocusNode();
  final confirmPassworFocusNode = FocusNode();
  final passwordController = TextEditingController();

  bool _loading = false;

  var values = {
    'currentPassword': '',
    'newPassword': '',
    'confirmPassword': ''
  };

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
      title: 'Success',
      message: 'Your Password has been changed',
      titleColor: themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
      backgroundColor:
          themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
      messageColor:
          themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
      duration: const Duration(seconds: 5),
    ).show(context);
  }

  Future<void> _savedForm() async {
    if (!(form.currentState?.validate() as bool)) return;
    form.currentState?.save();

    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).changePassword(
        values['currentPassword'] as String,
        values['newPassword'] as String,
      );
      passwordController.clear();
      await showSuccessMessage();
      setState(() {
        _loading = false;
      });
    } on HttpException catch (error) {
      if (error.toString().contains('Invalid credentails')) {
        showErrorDialog(
            'current password does not match', 'Invalid credentails');
      }
      passwordController.clear();
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const HeadingText(
          text: 'Change Password',
          size: 18,
          letterSpacing: 0.5,
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.back,
            size: 28,
            color: Color(0xff757575),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SafeArea(
        child: _loading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: form,
                      child: Column(
                        children: [
                          IOSTextInput(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            isPassword: true,
                            placeholder: "Please Enter Your Current Password",
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(newPasswordFocusNode);
                            },
                            title: "Current Password:",
                            validator: (String? value) {
                              if (!isLength(value!, 6)) {
                                return 'Please Enter a Vaild Password';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              values['currentPassword'] = value as String;
                            },
                          ),
                          IOSTextInput(
                            keyboardType: TextInputType.name,
                            isPassword: true,
                            placeholder: "Please Enter New Password",
                            textInputAction: TextInputAction.done,
                            focusNode: newPasswordFocusNode,
                            controler: passwordController,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(confirmPassworFocusNode);
                            },
                            title: "New Password:",
                            validator: (String? value) {
                              if (!isLength(value!, 6)) {
                                return 'Please Enter a Vaild Password';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              values['newPassword'] = value as String;
                            },
                          ),
                          IOSTextInput(
                            keyboardType: TextInputType.name,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            placeholder: "Please Confirm Your Password",
                            focusNode: confirmPassworFocusNode,
                            onFieldSubmitted: (_) {
                              _savedForm();
                            },
                            title: "Confirm Password:",
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
                    SizedBox(
                      width: double.infinity,
                      child: ActionButton(
                        margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                        padding: EdgeInsets.zero,
                        title: 'SAVE PASSWORD',
                        onPressed: _savedForm,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
