import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/layouts/heading_text.dart';
import '/pages/auth_page.dart' show AuthStage;

class AuthSelector extends StatelessWidget {
  final AuthStage authStage;
  final void Function(AuthStage) setAuthStage;

  const AuthSelector({
    required this.authStage,
    required this.setAuthStage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    final containerSize = (MediaQuery.of(context).size.width / 2) - 16;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: 48,
        color: themeDark ? const Color(0xff2d2d2d) : const Color(0xffeeeeee),
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () {
                      setAuthStage(AuthStage.signin);
                    },
                    padding: EdgeInsets.zero,
                    child: const HeadingText(
                      text: 'SIGNIN',
                      size: 18,
                      textAlign: TextAlign.center,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    onPressed: () {
                      setAuthStage(AuthStage.signup);
                    },
                    padding: EdgeInsets.zero,
                    child: const HeadingText(
                      text: 'SIGNUP',
                      size: 18,
                      textAlign: TextAlign.center,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  alignment: authStage == AuthStage.signin
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  width: containerSize * 2,
                  curve: Curves.easeInCirc,
                  child: Container(
                    width: containerSize,
                    height: 2,
                    color: themeDark
                        ? const Color(0xffeeeeee)
                        : const Color(0xff2d2d2d),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
