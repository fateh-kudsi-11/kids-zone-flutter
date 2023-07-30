import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/filtering_options.dart';
import '/providers/theme.dart';
import '/layouts/slider_paragraph.dart';
import '/layouts/paragraph_text.dart';

class SortButton extends StatelessWidget {
  final String action;
  final String title;

  const SortButton({Key? key, required this.action, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final sort = Provider.of<FilteringManger>(context).sort as String;
    final themeDark = Provider.of<ThemeManager>(context).themeMode;

    final Map<String, Color> colorsLight = {
      'active': const Color(0xff1f1f1f),
      'normal': const Color(0xffeeeeee),
    };

    final Map<String, Color> colorsDark = {
      'active': const Color(0xffeeeeee),
      'normal': const Color(0xff1f1f1f),
    };

    final colors = themeDark ? colorsDark : colorsLight;

    return Container(
      width: double.infinity,
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 10),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: action == sort ? colors['active'] : colors['normal'],
        child: action == sort
            ? SliderParagraph(text: title)
            : ParagraphText(text: title),
        onPressed: () {
          Provider.of<FilteringManger>(context, listen: false).setSort(action);
        },
      ),
    );
  }
}
