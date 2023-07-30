import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidszone/layouts/paragraph_text.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';

class NotiButton extends StatelessWidget {
  final String icon;
  final String title;
  final bool value;

  final void Function(bool)? onChanged;
  const NotiButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16),
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: SvgPicture.asset(
              height: 20,
              'assets/$icon.svg',
              color:
                  themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Color(0xff757575),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ParagraphText(
                    text: title,
                  ),
                  CupertinoSwitch(
                    activeColor: const Color(0xff3B864F),
                    value: value,
                    onChanged: onChanged,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
