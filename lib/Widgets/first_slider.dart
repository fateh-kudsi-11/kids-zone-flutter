import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme.dart';
import '../providers/filtering_options.dart';
import '../providers/bottom_navbar.dart';
import '/layouts/slider_heading.dart';
import '/layouts/slider_paragraph.dart';

class FirstSlider extends StatelessWidget {
  const FirstSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    final gender = Provider.of<FilteringManger>(context).gender;
    final tabController =
        Provider.of<BottomNavBarManger>(context).tabController;
    return GestureDetector(
      onTap: () {
        tabController.index = 1;
      },
      child: Container(
        width: double.infinity,
        height: 190,
        margin: const EdgeInsets.symmetric(horizontal: 16),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SliderParagraph(
                text: '50% OFF ALL ${gender == 'boys' ? 'BOYS' : 'GIRLS'} WEAR',
                size: 24,
                fontWeight: FontWeight.w500,
              ),
              const SliderHeading(
                text: 'CHECK OUT WINTER COLLECTION',
                size: 32,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
