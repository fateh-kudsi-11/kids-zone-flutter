import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:kidszone/layouts/action_button.dart';
import 'package:string_validator/string_validator.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/providers/address_book.dart';
import '/providers/auth.dart';
import '/layouts/heading_text.dart';
import '/layouts/ios_Text_input.dart';

class AddNewAddressBook extends StatefulWidget {
  const AddNewAddressBook({super.key});

  @override
  State<AddNewAddressBook> createState() => _AddNewAddressBookState();
}

class _AddNewAddressBookState extends State<AddNewAddressBook> {
  final form = GlobalKey<FormState>();
  final nameFoucsNode = FocusNode();
  final lastNameFoucsNode = FocusNode();
  final phoneFoucsNode = FocusNode();
  final addressFoucsNode = FocusNode();
  final cityFoucsNode = FocusNode();
  final postCodeFoucsNode = FocusNode();

  bool _loading = false;

  final values = {
    'firstName': '',
    'lastName': '',
    'phone': '',
    'address': '',
    'city': '',
    'postCode': '',
  };

  Future<void> showSuccessMessage() async {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    Navigator.of(context).popUntil((route) => route.isFirst);
    await Flushbar(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      title: 'Success',
      message: 'A New Address Book Has Been Add It.',
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
        'firstName': values['firstName'] as String,
        'lastName': values['lastName'] as String,
        'phone': values['phone'] as String,
        'address': values['address'] as String,
        'city': values['city'] as String,
        'postCode': values['postCode'] as String,
      };
      await Provider.of<AddressBook>(context, listen: false)
          .createAddressBooks(body);
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
    final user = Provider.of<Auth>(context).user;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const HeadingText(
            text: 'New Address Book',
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
                        const AddressHeader(
                          title: 'CONTACT DETAILS',
                        ),
                        IOSTextInput(
                          keyboardType: TextInputType.name,
                          placeholder: "Please Enter Your First Name",
                          initialValue: user?.firstName ?? user?.firstName,
                          focusNode: nameFoucsNode,
                          title: "First Name:",
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(lastNameFoucsNode);
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
                          initialValue: user?.lastName ?? user?.lastName,
                          placeholder: "Please Enter Your Last Name",
                          focusNode: lastNameFoucsNode,
                          title: "Last Name:",
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(phoneFoucsNode);
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
                          keyboardType: TextInputType.phone,
                          placeholder: "Please Enter Your Phone Number",
                          focusNode: phoneFoucsNode,
                          title: "Mobile:",
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(addressFoucsNode);
                          },
                          validator: (String? value) {
                            if (!isLength(value!, 1)) {
                              return 'Please Enter a Your Phone Number';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            values['phone'] = value as String;
                          },
                        ),
                        const AddressHeader(
                          title: 'ADDRESS DETAILS',
                        ),
                        IOSTextInput(
                          keyboardType: TextInputType.name,
                          placeholder: "Please Enter Your Address",
                          focusNode: addressFoucsNode,
                          title: "Address:",
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(cityFoucsNode);
                          },
                          validator: (String? value) {
                            if (!isLength(value!, 1)) {
                              return 'Please Enter a Your Address';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            values['address'] = value as String;
                          },
                        ),
                        IOSTextInput(
                          keyboardType: TextInputType.name,
                          placeholder: "Please Enter Your City / Town",
                          focusNode: cityFoucsNode,
                          title: "City / Town:",
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(postCodeFoucsNode);
                          },
                          validator: (String? value) {
                            if (!isLength(value!, 1)) {
                              return 'Please Enter a Your City / Town';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            values['city'] = value as String;
                          },
                        ),
                        IOSTextInput(
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.go,
                          placeholder: "Please Enter Your Post Code",
                          focusNode: postCodeFoucsNode,
                          title: "Post Code:",
                          onFieldSubmitted: (_) {
                            _savedForm();
                          },
                          validator: (String? value) {
                            if (!isLength(value!, 1)) {
                              return 'Please Enter a Your Post Code';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            values['postCode'] = value as String;
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ActionButton(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: EdgeInsets.zero,
                            title: 'ADD ADDRESS BOOK',
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

class AddressHeader extends StatelessWidget {
  final String title;
  const AddressHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    return Container(
      width: double.infinity,
      height: 46,
      margin: const EdgeInsets.only(top: 5),
      color: themeDark ? const Color(0xff1d1d1d) : const Color(0xffeeeeee),
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: HeadingText(
        text: title,
        size: 18,
      ),
    );
  }
}
