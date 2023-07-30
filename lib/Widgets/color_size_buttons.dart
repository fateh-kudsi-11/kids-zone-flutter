import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/layouts/heading_text.dart';

class ColorSizeButtons extends StatelessWidget {
  final String selectedColor;
  final String selectedSize;
  final List<String> colorList;
  final List<String> sizeList;

  final void Function(String) setColor;
  final void Function(String) setSize;

  const ColorSizeButtons({
    Key? key,
    required this.selectedColor,
    required this.selectedSize,
    required this.setColor,
    required this.setSize,
    required this.colorList,
    required this.sizeList,
  }) : super(key: key);

  Widget buildSelecter(String type) {
    final items = type == 'color' ? colorList : sizeList;

    return CupertinoPicker(
        itemExtent: 64,
        onSelectedItemChanged: (index) {
          if (type == 'color') {
            setColor(colorList[index]);
          } else {
            setSize(sizeList[index]);
          }
        },
        children: items
            .map((e) => Center(
                  child: Text(e),
                ))
            .toList());
  }

  void showPicker(String type, BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: ((context) => CupertinoActionSheet(
              actions: [SizedBox(height: 200, child: buildSelecter(type))],
              cancelButton: CupertinoActionSheetAction(
                isDefaultAction: true,
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: Provider.of<ThemeManager>(context, listen: false)
                              .themeMode
                          ? const Color(0xffeeeeee)
                          : const Color(0xff1f1f1f)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: type == 'color'
                  ? const Text('Selecte Color')
                  : const Text('Selecte Size'),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 20),
      child: Container(
        width: double.infinity,
        height: 47,
        decoration: BoxDecoration(
          color: themeDark ? const Color(0xff1d1d1d) : const Color(0xffeeeeee),
          border: Border.symmetric(
            horizontal: BorderSide(
                color: themeDark
                    ? const Color(0xff4d4d4d)
                    : const Color(0xffd9d9d9),
                width: 1.25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HeadingText(
                      text: selectedColor == '' ? 'Color' : selectedColor,
                      size: 24,
                    ),
                    const Icon(
                      CupertinoIcons.chevron_down,
                      size: 20,
                      color: Color(0xff1f1f1f),
                    )
                  ],
                ),
                onPressed: () {
                  setColor(colorList[0]);
                  showPicker('color', context);
                },
              ),
            ),
            Container(
              width: 1,
              height: 20,
              color:
                  themeDark ? const Color(0xff4d4d4d) : const Color(0xffd9d9d9),
            ),
            Expanded(
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HeadingText(
                      text: selectedSize == '' ? 'Size' : selectedSize,
                      size: 24,
                    ),
                    const Icon(
                      CupertinoIcons.chevron_down,
                      size: 20,
                      color: Color(0xff1f1f1f),
                    )
                  ],
                ),
                onPressed: () {
                  showPicker('size', context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
