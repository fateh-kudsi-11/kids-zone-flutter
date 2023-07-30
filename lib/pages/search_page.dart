import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/models/category_selecter.dart';
import '/Widgets/category_item.dart';
import '/Widgets/gender_selector.dart';
import '/layouts/logo.dart';
import '../providers/filtering_options.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gender = Provider.of<FilteringManger>(context).gender;

    final categories = gender == 'boys'
        ? CategorySelect.boysCategory
        : CategorySelect.girlsCategory;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Logo(),
            ),
            const GenderSelector(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) => CategoryItem(
                  category: categories[index],
                ),
                itemCount: categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
