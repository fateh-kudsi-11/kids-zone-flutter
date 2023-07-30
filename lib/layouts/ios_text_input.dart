import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/layouts/paragraph_text.dart';
import '/providers/theme.dart';

class IOSTextInput extends StatelessWidget {
  final String title;
  final String placeholder;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controler;
  final String? Function(String?) validator;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? initialValue;
  final double? width;

  const IOSTextInput(
      {required this.title,
      required this.placeholder,
      required this.keyboardType,
      required this.validator,
      this.initialValue,
      this.textInputAction = TextInputAction.next,
      this.isPassword = false,
      this.focusNode,
      this.onFieldSubmitted,
      this.onSaved,
      this.controler,
      this.width = double.infinity,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 15),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: ParagraphText(
              text: title,
              size: 14,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
            ),
          ),
          CupertinoTextFormFieldRow(
            focusNode: focusNode,
            style: TextStyle(
              color:
                  themeDark ? const Color(0XFFeeeeee) : const Color(0XFF1f1f1f),
            ),
            autocorrect: false,
            initialValue: initialValue,
            controller: controler,
            onSaved: onSaved,
            textAlign: TextAlign.left,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
            obscureText: isPassword ? true : false,
            keyboardType: keyboardType,
            keyboardAppearance: themeDark ? Brightness.dark : Brightness.light,
            textInputAction: textInputAction,
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            placeholder: placeholder,
            placeholderStyle: TextStyle(
                color: themeDark
                    ? const Color(0XFFeeeeee)
                    : const Color(0XFF1f1f1f),
                fontSize: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffD9D9D9),
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
