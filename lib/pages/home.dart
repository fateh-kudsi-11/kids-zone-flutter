import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/providers/filtering_options.dart';
import '/providers/stage.dart';
import '/Widgets/category_slider.dart';
import '/Widgets/gender_selector.dart';
import '/Widgets/second_slider.dart';
import '/Widgets/first_slider.dart';
import '/Widgets/page_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    final gender = Provider.of<FilteringManger>(context).gender;
    return CupertinoPageScaffold(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value:
            themeDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: [
              const PageHeader(),
              const GenderSelector(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const FirstSlider(),
                      const SecondSlider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: gender == 'boys'
                              ? const [
                                  CategorySlider(
                                    image: 'assets/66.png',
                                    title: 'Suits',
                                  ),
                                  SizedBox(),
                                  CategorySlider(
                                    image: 'assets/667.png',
                                    title: 'Jackets',
                                  ),
                                ]
                              : const [
                                  CategorySlider(
                                    image: 'assets/35.png',
                                    title: 'Skirts',
                                  ),
                                  SizedBox(),
                                  CategorySlider(
                                    image: 'assets/36.png',
                                    title: 'Jackets',
                                  ),
                                ],
                        ),
                      ),
                      Switch.adaptive(
                        activeTrackColor: Colors.black,
                        focusColor: Colors.black,
                        activeColor: const Color(0xffeeeeee),
                        value: themeDark,
                        onChanged: (value) {
                          Provider.of<ThemeManager>(context, listen: false)
                              .toggleTheme(value);
                        },
                      ),
                      CupertinoButton.filled(
                          child: const Text('Stage'),
                          onPressed: () {
                            Provider.of<StageManger>(context, listen: false)
                                .setStage('auth');
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
