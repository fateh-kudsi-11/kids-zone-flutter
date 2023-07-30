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

class MyDetails extends StatefulWidget {
  const MyDetails({super.key});

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  final form = GlobalKey<FormState>();
  final emailControler = TextEditingController();
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();

  bool _loading = false;

  var values = {'email': '', 'firstName': '', 'lastName': ''};

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
      message: 'Your Details has been changed',
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
      await Provider.of<Auth>(context, listen: false).changeDetails(
          values['email'] as String,
          values['firstName'] as String,
          values['lastName'] as String);
      await showSuccessMessage();
      setState(() {
        _loading = false;
      });
    } on HttpException catch (error) {
      if (error.toString().contains('Duplicate field value entered')) {
        showErrorDialog('This email is already in use', 'Invalid credentails');
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false).user;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const HeadingText(
          text: 'My Details',
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
                            initialValue: user?.email ?? user?.email,
                            textInputAction: TextInputAction.done,
                            placeholder: "Please Enter Your Email Address",
                            title: "EMAIL ADDRESS:",
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
                            textInputAction: TextInputAction.done,
                            initialValue: user?.firstName ?? user?.firstName,
                            focusNode: firstNameFocusNode,
                            title: "First Name:",
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
                            textInputAction: TextInputAction.done,
                            initialValue: user?.lastName ?? user?.lastName,
                            placeholder: "Please Enter Your Last Name",
                            focusNode: lastNameFocusNode,
                            title: "Last Name:",
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
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ActionButton(
                        margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                        padding: EdgeInsets.zero,
                        title: 'SAVE CHANGE',
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
