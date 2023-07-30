import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/Widgets/pricerange_popup.dart';
import '/providers/theme.dart';
import '/layouts/paragraph_text.dart';

class PriceRangepopubButton extends StatelessWidget {
  const PriceRangepopubButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: themeDark
                    ? const Color(0xff4d4d4d)
                    : const Color(0xffd9d9d9),
                width: 0.75),
          ),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ParagraphText(
                text: 'Price',
                size: 14,
                fontWeight: FontWeight.w400,
              ),
              Icon(
                CupertinoIcons.chevron_down,
                color: Color(0xff757575),
              )
            ],
          ),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => const PriceRangPopup(),
            );
          },
        ),
      ),
    );
  }
}
