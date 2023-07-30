import 'package:flutter/cupertino.dart';
import '/pages/save_item_page.dart';

class IOSSaveItemsNavigator extends StatelessWidget {
  const IOSSaveItemsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) => const SavedItemPage(),
    );
  }
}
