import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidszone/layouts/paragraph_text.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';

class AccountButton extends StatelessWidget {
  final String icon;
  final String title;
  final bool isBorder;
  final void Function()? onPressed;
  const AccountButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return Container(
      width: double.infinity,
      //height: 44,
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
            child: CupertinoButton(
              onPressed: onPressed,
              padding: EdgeInsets.zero,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                width: double.infinity,
                decoration: isBorder
                    ? const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: Color(0xff757575),
                          ),
                        ),
                      )
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ParagraphText(
                      text: title,
                    ),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 30,
                      color: themeDark
                          ? const Color(0xffeeeeee)
                          : const Color(0xff757575),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
