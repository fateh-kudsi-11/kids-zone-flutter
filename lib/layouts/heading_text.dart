import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';

class HeadingText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double letterSpacing;

  const HeadingText({
    Key? key,
    required this.text,
    this.size = 16,
    this.textAlign = TextAlign.left,
    this.letterSpacing = 0,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.antonio(
        fontSize: size,
        letterSpacing: letterSpacing,
        color: themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
        fontWeight: fontWeight,
      ),
    );
  }
}
