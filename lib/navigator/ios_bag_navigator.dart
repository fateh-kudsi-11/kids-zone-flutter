import 'package:flutter/cupertino.dart';
import '/pages/bag_page.dart';

class IOSBagNavigator extends StatelessWidget {
  const IOSBagNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) => const BagPage(),
    );
  }
}
