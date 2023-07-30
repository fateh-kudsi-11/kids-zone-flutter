import 'package:flutter/cupertino.dart';
import 'package:kidszone/Widgets/pricerange_popup_button.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/providers/products.dart';
import '/providers/filtering_options.dart';
import '/layouts/heading_text.dart';
import '/Widgets/filter_popup_button.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});
  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    final loading = Provider.of<Products>(context).loading;
    return CupertinoPageScaffold(
      backgroundColor:
          themeDark ? const Color(0xff1d1d1d) : const Color(0xffeeeeee),
      navigationBar: CupertinoNavigationBar(
        middle: const HeadingText(
          text: 'Filter',
          size: 18,
          letterSpacing: 0.5,
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.back,
            size: 28,
            color: Color(0xff757575),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        trailing: Container(
          constraints: const BoxConstraints(maxHeight: 35),
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            onPressed: () async {
              Provider.of<FilteringManger>(context, listen: false)
                  .clearFilterOutput();
              await Provider.of<Products>(context, listen: false)
                  .fetchProducts();
              //  Navigator.of(context).pop();
            },
            color: themeDark
                ? const Color.fromARGB(255, 36, 36, 36)
                : const Color(0xffeeeeee),
            borderRadius: const BorderRadius.all(Radius.zero),
            child: const HeadingText(
              text: 'Clear All',
              size: 14,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 15),
          width: double.infinity,
          constraints: const BoxConstraints(
              maxHeight: 220, minHeight: 100, maxWidth: double.infinity),
          decoration: BoxDecoration(
            color:
                themeDark ? const Color(0xff1f1f1f) : const Color(0xffffffff),
            border: Border.symmetric(
              horizontal: BorderSide(
                color: themeDark
                    ? const Color(0xff4d4d4d)
                    : const Color(0xffd9d9d9),
              ),
            ),
          ),
          child: loading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : const Column(
                  children: [
                    FilterPopupButton(
                      title: 'Brand',
                      kind: 'brands',
                    ),
                    FilterPopupButton(
                      title: 'Color',
                      kind: 'colors',
                    ),
                    FilterPopupButton(
                      title: 'Size',
                      kind: 'sizes',
                    ),
                    PriceRangepopubButton()
                  ],
                ),
        ),
      ),
    );
  }
}
