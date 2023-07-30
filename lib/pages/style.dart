import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/bottom_navbar.dart';
import '/providers/stage.dart';
import '../layouts/heading_text.dart';
import '../layouts/paragraph_text.dart';
import '../layouts/logo.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tabController =
        Provider.of<BottomNavBarManger>(context, listen: false).tabController;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: const Color(0xff1f1f1f),
                      width: 60,
                      height: 60,
                    ),
                    Container(
                      color: const Color(0xffd9d9d9),
                      width: 60,
                      height: 60,
                    ),
                    Container(
                      color: const Color(0xffeeeeee),
                      width: 60,
                      height: 60,
                    ),
                    Container(
                      color: const Color(0xff242424),
                      width: 60,
                      height: 60,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: HeadingText(
                        text: "Heading 0",
                        size: 48,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: HeadingText(
                        text: "Heading 1",
                        size: 32,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: HeadingText(
                        text: "Heading 2",
                        size: 24,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: HeadingText(
                        text: "Heading 3",
                        size: 18,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: HeadingText(
                        text: "Heading 4",
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: ParagraphText(
                        text: "Paragraph Text",
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: ParagraphText(
                        text: "Paragraph Text Bold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: ParagraphText(
                        text: "Paragraph Text Bold",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Logo(),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: CupertinoButton.filled(
                          child: const Text('test'),
                          onPressed: () {
                            //  tabController.index = 4;
                            Provider.of<StageManger>(context, listen: false)
                                .setStage('auth');
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
