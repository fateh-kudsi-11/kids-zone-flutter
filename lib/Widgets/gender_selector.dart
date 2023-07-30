import 'package:flutter/cupertino.dart';
import 'package:kidszone/layouts/heading_text.dart';
import 'package:provider/provider.dart';
import '../providers/theme.dart';
import '../providers/filtering_options.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    final gender = Provider.of<FilteringManger>(context).gender;
    final containerSize = (MediaQuery.of(context).size.width / 2) - 16;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: 48,
        color: themeDark ? const Color(0xff2d2d2d) : const Color(0xffeeeeee),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () {
                      Provider.of<FilteringManger>(context, listen: false)
                          .setGender('boys');
                    },
                    padding: EdgeInsets.zero,
                    child: const HeadingText(
                      text: 'BOYS',
                      size: 18,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    onPressed: () {
                      Provider.of<FilteringManger>(context, listen: false)
                          .setGender('girls');
                    },
                    padding: EdgeInsets.zero,
                    child: const HeadingText(
                      text: 'GIRLS',
                      size: 18,
                      textAlign: TextAlign.center,
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
                  alignment: gender == 'girls'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
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
