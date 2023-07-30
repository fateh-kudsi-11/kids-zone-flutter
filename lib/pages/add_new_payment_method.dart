import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:kidszone/layouts/action_button.dart';
import 'package:string_validator/string_validator.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/providers/payment_method.dart';
import '/layouts/heading_text.dart';
import '/layouts/ios_Text_input.dart';

class AddNewPaymentMethod extends StatefulWidget {
  const AddNewPaymentMethod({super.key});

  @override
  State<AddNewPaymentMethod> createState() => _AddNewPaymentMethodState();
}

class _AddNewPaymentMethodState extends State<AddNewPaymentMethod> {
  final form = GlobalKey<FormState>();
  final cardNumberFocusNode = FocusNode();
  final monthFoucsNode = FocusNode();
  final yearFoucsNode = FocusNode();
  final cardNameFoucsNode = FocusNode();

  bool _loading = false;

  final values = {
    'cardNumber': '',
    'month': '',
    'year': '',
    'cardName': '',
  };

  Future<void> showSuccessMessage() async {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    Navigator.of(context).popUntil((route) => route.isFirst);
    await Flushbar(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      title: 'Success',
      message: 'A New Payment Method  Has Been Add It.',
      titleColor: themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
      backgroundColor:
          themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
      messageColor:
          themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
      duration: const Duration(seconds: 5),
    ).show(context);
  }

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

  Future<void> _savedForm() async {
    if (!(form.currentState?.validate() as bool)) return;
    form.currentState?.save();

    setState(() {
      _loading = true;
    });
    try {
      final body = {
        'cardName': values['cardName'] as String,
        'month': values['month'] as String,
        'year': values['year'] as String,
        'cardNumber': values['cardNumber'] as String,
      };
      await Provider.of<PaymentMethod>(context, listen: false)
          .createPaymentMethod(body);
      await showSuccessMessage();
    } on HttpException catch (error) {
      if (error.toString().contains('Invalid credentails')) {
        showErrorDialog(
            'Please check your email or your password', 'Invalid credentails');
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const HeadingText(
            text: 'New Payment Method',
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
        child: _loading
            ? const Center(
                child: CupertinoActivityIndicator(
                  radius: 18,
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: form,
                    child: Column(
                      children: [
                        IOSTextInput(
                          keyboardType: TextInputType.name,
                          placeholder: "Please Enter Your Card Number",
                          focusNode: cardNumberFocusNode,
                          title: "Card Number:",
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(monthFoucsNode);
                          },
                          validator: (String? value) {
                            if (!isLength(value!, 1)) {
                              return 'Please Enter a Your First Name';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            values['cardNumber'] = value as String;
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IOSTextInput(
                                keyboardType: TextInputType.name,
                                placeholder: "Month",
                                width: 150,
                                title: "EXPIRY DATE",
                                focusNode: monthFoucsNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(yearFoucsNode);
                                },
                                validator: (String? value) {
                                  if (!isLength(value!, 1)) {
                                    return 'Please Enter a Your First Name';
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  values['month'] = value as String;
                                },
                              ),
                              IOSTextInput(
                                keyboardType: TextInputType.name,
                                placeholder: "Year",
                                focusNode: yearFoucsNode,
                                width: 150,
                                title: "",
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(cardNameFoucsNode);
                                },
                                validator: (String? value) {
                                  if (!isLength(value!, 1)) {
                                    return 'Please Enter a Your First Name';
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  values['year'] = value as String;
                                },
                              ),
                            ],
                          ),
                        ),
                        IOSTextInput(
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.go,
                          placeholder: "Please Enter Your Card Name",
                          focusNode: cardNameFoucsNode,
                          title: "Card Name:",
                          onFieldSubmitted: (_) {
                            _savedForm();
                          },
                          validator: (String? value) {
                            if (!isLength(value!, 1)) {
                              return 'Please Enter a Your Card Name';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            values['cardName'] = value as String;
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ActionButton(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: EdgeInsets.zero,
                            title: 'SAVE CARD',
                            onPressed: _savedForm,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
