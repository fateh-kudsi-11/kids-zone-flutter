import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';

class Logo extends StatelessWidget {
  final double? height;

  const Logo({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return SvgPicture.asset(
      height: height,
      'assets/logoDark.svg',
      color: themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
    );
  }
}
