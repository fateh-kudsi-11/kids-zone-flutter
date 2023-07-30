import 'package:flutter/cupertino.dart';
import '/Widgets/sort_button.dart';

class SortpopUp extends StatelessWidget {
  const SortpopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 200,
        child: const Column(
          children: [
            SortButton(
              title: 'What\'s new',
              action: 'newProduct',
            ),
            SortButton(
              title: 'Price high to low',
              action: 'priceHighToLow',
            ),
            SortButton(
              title: 'Price low to high',
              action: 'priceLowToHigh',
            ),
          ],
        ),
      ),
    );
  }
}
