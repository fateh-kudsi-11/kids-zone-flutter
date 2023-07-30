import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_range_slider_improved/cupertino_range_slider.dart';
import '/providers/products.dart';
import '/providers/filtering_options.dart';
import '/providers/theme.dart';
import '/layouts/heading_text.dart';
import '/layouts/slider_heading.dart';

class PriceRangPopup extends StatefulWidget {
  const PriceRangPopup({
    Key? key,
  }) : super(key: key);

  @override
  State<PriceRangPopup> createState() => _PriceRangPopupState();
}

class _PriceRangPopupState extends State<PriceRangPopup> {
  double minValue = 100;
  double maxValue = 101;
  double min = 100;
  double max = 101;

  void closePopup(BuildContext context) {
    Provider.of<FilteringManger>(context, listen: false)
        .setFilterOutput('priceRange', '');
    Provider.of<Products>(context, listen: false).fetchProducts();
    Navigator.pop(context);
  }

  void onSubmit(
    BuildContext context,
  ) {
    String value = '$minValue,$maxValue';

    Provider.of<FilteringManger>(context, listen: false)
        .setFilterOutput('priceRange', value);
    Provider.of<Products>(context, listen: false).fetchProducts();
    Navigator.pop(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final priceRangeValues =
        Provider.of<Products>(context, listen: false).fetchPriceRangeValues();
    min = (priceRangeValues['minPrice'] as int).toDouble() / 1000;
    minValue = (priceRangeValues['minPrice'] as int).toDouble() / 1000;
    max = (priceRangeValues['maxPrice'] as int).toDouble() / 1000;
    maxValue = (priceRangeValues['maxPrice'] as int).toDouble() / 1000;
  }

  @override
  Widget build(BuildContext context) {
    final containerHeight = MediaQuery.of(context).size.height * 0.90;
    final themeDark = Provider.of<ThemeManager>(context).themeMode;

    return CupertinoPopupSurface(
      child: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: containerHeight,
        color: themeDark ? const Color(0xff1d1d1d) : const Color(0xffffffff),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 8,
                  child: HeadingText(
                    text: 'Price',
                    size: 18,
                    textAlign: TextAlign.center,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 35),
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      onPressed: () {
                        closePopup(context);
                      },
                      color: themeDark
                          ? const Color.fromARGB(255, 36, 36, 36)
                          : const Color(0xffeeeeee),
                      borderRadius: const BorderRadius.all(Radius.zero),
                      child: const HeadingText(
                        text: 'Clear',
                        size: 14,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: CupertinoRangeSlider(
                maxValue: maxValue,
                minValue: minValue,
                min: min,
                max: max,
                activeColor: themeDark
                    ? const Color(0xffeeeeee)
                    : const Color(0xff1f1f1f),
                onMaxChanged: (value) {
                  setState(() {
                    maxValue = value;
                  });
                },
                onMinChanged: (value) {
                  setState(() {
                    minValue = value;
                  });
                },
              ),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadingText(text: '${minValue.round()}'),
                    HeadingText(text: '${maxValue.round()}')
                  ],
                )),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 20),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                color: themeDark
                    ? const Color(0xffeeeeee)
                    : const Color(0xff1f1f1f),
                onPressed: (min == minValue && max == maxValue)
                    ? null
                    : () {
                        onSubmit(context);
                      },
                child: const SliderHeading(
                  text: 'View Item',
                  size: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
