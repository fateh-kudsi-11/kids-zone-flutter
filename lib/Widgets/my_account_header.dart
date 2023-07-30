import 'package:flutter/cupertino.dart';
import 'package:kidszone/layouts/heading_text.dart';
import 'package:kidszone/layouts/paragraph_text.dart';
import 'package:kidszone/layouts/slider_heading.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/providers/auth.dart';

class MyAccountHeader extends StatelessWidget {
  const MyAccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    final user = Provider.of<Auth>(context).user;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: themeDark
                      ? const [
                          Color(0xffeeeeee),
                          Color(0xffd9d9d9),
                        ]
                      : const [
                          Color(0xff2d2d2d),
                          Color(0xff1f1f1f),
                        ],
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: 90,
                  height: 90,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeDark
                        ? const Color(0xffeeeeee)
                        : const Color(0xff1f1f1f),
                    border: Border.all(
                      width: 1.5,
                      color: themeDark
                          ? const Color(0xff1f1f1f)
                          : const Color(0xffeeeeee),
                    ),
                  ),
                  child: Center(
                    child: SliderHeading(
                      text:
                          '${user?.firstName[0].toUpperCase()}${user?.lastName[0].toUpperCase()}',
                      size: 32,
                      letterSpacing: 0.75,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: ParagraphText(
            text: 'Hi,',
            size: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: HeadingText(
            text:
                '${user?.firstName.toUpperCase()} ${user?.lastName.toUpperCase()}',
            size: 18,
          ),
        )
      ],
    );
  }
}
