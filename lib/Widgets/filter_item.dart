import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/layouts/paragraph_text.dart';

class FilterItem extends StatelessWidget {
  final String title;
  final bool isChecked;
  final String value;
  final Function onSelecte;
  const FilterItem(
      {Key? key,
      required this.title,
      required this.isChecked,
      required this.onSelecte,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: themeDark
                    ? const Color(0xff4d4d4d)
                    : const Color(0xffd9d9d9),
                width: 0.75),
          ),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ParagraphText(
                text: title,
                size: 14,
                fontWeight: FontWeight.w400,
              ),
              Icon(
                CupertinoIcons.check_mark,
                color: const Color(0xff3B864F).withOpacity(isChecked ? 1 : 0),
              )
            ],
          ),
          onPressed: () {
            onSelecte(value);
          },
        ),
      ),
    );
  }
}
