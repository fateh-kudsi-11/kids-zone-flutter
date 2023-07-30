import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';

class AccountDivider extends StatelessWidget {
  const AccountDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return Container(
      width: double.infinity,
      height: 8,
      decoration: BoxDecoration(
        color: themeDark ? const Color(0xff1d1d1d) : const Color(0xffeeeeee),
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1,
            color:
                themeDark ? const Color(0xff1f1f1f) : const Color(0xffdddddd),
          ),
        ),
      ),
    );
  }
}
