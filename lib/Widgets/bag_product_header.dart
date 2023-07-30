import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/layouts/paragraph_text.dart';
import '/providers/theme.dart';
import '/providers/bag.dart';

class BagProductHeader extends StatelessWidget {
  const BagProductHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    final products = Provider.of<Bag>(context).bagProducts;
    final total = Provider.of<Bag>(context, listen: false).getTotalSum();

    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: themeDark ? const Color(0xff1d1d1d) : const Color(0xfff7f7f7),
          border: Border(
              bottom: BorderSide(
            width: 0.5,
            color:
                themeDark ? const Color(0xff4d4d4d) : const Color(0xffd9d9d9),
          ))),
      child: Container(
        alignment: Alignment.center,
        child: ParagraphText(
          text:
              '${products.length} ${products.length == 1 ? 'Item' : 'Items'} Total \$$total',
          size: 18,
        ),
      ),
    );
  }
}
