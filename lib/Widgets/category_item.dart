import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/category_selecter.dart';
import '/layouts/heading_text.dart';
import '/providers/theme.dart';
import '/providers/filtering_options.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: GestureDetector(
        onTap: () {
          Provider.of<FilteringManger>(context, listen: false)
              .setDirectory(category.title.toLowerCase());
          Navigator.of(context).pushNamed('/products');
        },
        child: Container(
          color: themeDark ? const Color(0xff2d2d2d) : const Color(0xffeeeeee),
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadingText(
                text: category.title,
                size: 32,
              ),
              Image.asset(category.image)
            ],
          ),
        ),
      ),
    );
  }
}
