import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/layouts/paragraph_text.dart';

class ExpandableSection extends StatefulWidget {
  final EdgeInsets mainPadding;
  final EdgeInsets mainMargin;
  final String title;
  final Widget child;

  const ExpandableSection({
    required this.mainMargin,
    required this.mainPadding,
    required this.title,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    return Container(
      margin: widget.mainMargin,
      padding: widget.mainPadding,
      child: Column(
        children: [
          Container(
            height: 44,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: themeDark
                      ? const Color(0xFFeeeeee).withOpacity(0.2)
                      : const Color(0xFF000000).withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ParagraphText(text: widget.title),
                  Icon(
                    isOpen ? CupertinoIcons.minus : CupertinoIcons.add,
                    color: const Color(0xFF757575),
                  )
                ],
              ),
              onPressed: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
            ),
          ),
          SizedBox(
            child: Container(
              constraints:
                  BoxConstraints(maxHeight: isOpen ? double.infinity : 0),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
