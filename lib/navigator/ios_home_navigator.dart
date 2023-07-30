import 'package:flutter/cupertino.dart';
import '/pages/home.dart';

class IOSHomeNavigator extends StatelessWidget {
  const IOSHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) => const HomePage(),
    );
  }
}
