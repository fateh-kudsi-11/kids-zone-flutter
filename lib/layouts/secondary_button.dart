import 'package:flutter/cupertino.dart';
import 'package:kidszone/layouts/heading_text.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';

class SecondaryButton extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final String title;
  final double? width;
  final double? height;
  final void Function()? onPressed;

  const SecondaryButton({
    Key? key,
    required this.margin,
    required this.padding,
    required this.title,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        margin: margin,
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
              color:
                  themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
              width: 1),
        ),
        child: CupertinoButton(
          onPressed: onPressed,
          borderRadius: const BorderRadius.all(
            Radius.zero,
          ),
          child: HeadingText(
            text: title,
            size: 18,
          ),
        ),
      ),
    );
  }
}
