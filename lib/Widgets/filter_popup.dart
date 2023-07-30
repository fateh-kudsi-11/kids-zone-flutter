import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/products.dart';
import '/providers/filtering_options.dart';
import '/providers/theme.dart';
import '/Widgets/filter_item.dart';
import '/layouts/heading_text.dart';
import '/layouts/slider_heading.dart';

class FilterPopup extends StatefulWidget {
  final String kind;
  final String title;
  const FilterPopup({Key? key, required this.kind, required this.title})
      : super(key: key);

  @override
  State<FilterPopup> createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  List<String> _selectedItem = [];

  void closePopup(BuildContext context) {
    Provider.of<FilteringManger>(context, listen: false)
        .setFilterOutput(widget.title.toLowerCase(), '');
    Provider.of<Products>(context, listen: false).fetchProducts();
    Navigator.pop(context);
  }

  void onSelect(String item) {
    setState(() {
      final index = _selectedItem.indexWhere((element) => element == item);

      if (index == -1) {
        _selectedItem.add(item);
      } else {
        _selectedItem.removeAt(index);
      }
    });
  }

  void onSubmit(
    BuildContext context,
  ) {
    String value = _selectedItem.join(',');

    Provider.of<FilteringManger>(context, listen: false)
        .setFilterOutput(widget.title.toLowerCase(), value);
    Provider.of<Products>(context, listen: false).fetchProducts();
    Navigator.pop(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final filter =
        Provider.of<FilteringManger>(context, listen: false).filterOutput;
    final selectedFilter = filter[widget.title.toLowerCase()] as String;
    _selectedItem = selectedFilter.split(',');
  }

  @override
  Widget build(BuildContext context) {
    final containerHeight = MediaQuery.of(context).size.height * 0.90;
    final items =
        Provider.of<Products>(context).fetchFilterElement(widget.kind);
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
                Expanded(
                  flex: 8,
                  child: HeadingText(
                    text: widget.title,
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
            items == null
                ? const Text('no Filter options')
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => FilterItem(
                        key: Key(items[index].title),
                        title:
                            '${items[index].title} - (${items[index].count})',
                        isChecked: _selectedItem.contains(items[index].title),
                        value: items[index].title,
                        onSelecte: onSelect,
                      ),
                      itemCount: items.length,
                    ),
                  ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 20),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                color: themeDark
                    ? const Color(0xffeeeeee)
                    : const Color(0xff1f1f1f),
                onPressed: _selectedItem.isEmpty
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
