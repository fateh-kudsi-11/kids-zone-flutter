import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/Widgets/sort_popup.dart';
import '/layouts/heading_text.dart';

class SortFilter extends StatelessWidget {
  const SortFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    return Container(
      width: double.infinity,
      height: 47,
      decoration: BoxDecoration(
        color: themeDark ? const Color(0xff1d1d1d) : const Color(0xfff7f7f7),
        border: Border(
          bottom: BorderSide(
              color:
                  themeDark ? const Color(0xff4d4d4d) : const Color(0xffd9d9d9),
              width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const HeadingText(
                text: 'SORT',
                size: 18,
              ),
              onPressed: () {
                showCupertinoModalPopup(
                    context: context, builder: (context) => const SortpopUp());
              },
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color:
                themeDark ? const Color(0xff4d4d4d) : const Color(0xffd9d9d9),
          ),
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const HeadingText(
                text: 'FILTER',
                size: 18,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/filter');
              },
            ),
          )
        ],
      ),
    );
  }
}
