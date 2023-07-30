import 'package:flutter/cupertino.dart';
import 'package:kidszone/Widgets/filter_popup.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/layouts/paragraph_text.dart';

class FilterPopupButton extends StatelessWidget {
  final String title;
  final String kind;
  const FilterPopupButton({Key? key, required this.title, required this.kind})
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
              const Icon(
                CupertinoIcons.chevron_down,
                color: Color(0xff757575),
              )
            ],
          ),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => FilterPopup(
                title: title,
                kind: kind,
              ),
            );
          },
        ),
      ),
    );
  }
}
