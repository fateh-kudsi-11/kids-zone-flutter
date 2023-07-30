import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/layouts/slider_heading.dart';

class ActionButton extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final String title;
  final double? width;
  final double? height;
  final void Function()? onPressed;

  const ActionButton({
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
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: CupertinoButton(
        color: themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
        onPressed: onPressed,
        borderRadius: const BorderRadius.all(Radius.zero),
        child: SliderHeading(
          text: title,
          size: 24,
        ),
      ),
    );
  }
}
