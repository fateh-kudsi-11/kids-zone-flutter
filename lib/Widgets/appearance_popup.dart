import 'package:flutter/cupertino.dart';
import '/Widgets/appearance_button.dart';

class AppearancepopUp extends StatelessWidget {
  const AppearancepopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 150,
        child: const Column(
          children: [
            AppearanceButton(
              title: 'Light',
              action: 'light',
              icon: CupertinoIcons.sun_max_fill,
            ),
            AppearanceButton(
              title: 'Dark',
              action: 'dark',
              icon: CupertinoIcons.moon,
            ),
          ],
        ),
      ),
    );
  }
}
