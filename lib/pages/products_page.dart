import 'package:flutter/cupertino.dart';
import 'package:kidszone/layouts/paragraph_text.dart';
import 'package:provider/provider.dart';
import '/providers/products.dart';
import '/providers/wish_list.dart';
import '/providers/filtering_options.dart';
import '/providers/theme.dart';
import '/layouts/heading_text.dart';
import '/Widgets/product_item.dart';
import '/Widgets/sort_filter_options.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final directory = Provider.of<FilteringManger>(context).directory as String;
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    return CupertinoPageScaffold(
      backgroundColor:
          themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
      navigationBar: CupertinoNavigationBar(
        middle: HeadingText(
          text: directory == ''
              ? 'Products'
              : '${directory[0].toUpperCase()}${directory.substring(1, directory.length)}',
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
            Provider.of<FilteringManger>(context, listen: false)
                .setDirectory('');
          },
        ),
      ),
      child: FutureBuilder(
        future: Future.wait(
          [
            Provider.of<Products>(context, listen: false).fetchProducts(),
            Provider.of<WishList>(context, listen: false).fetchWishList(),
          ],
        ),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Consumer<Products>(
                builder: (context, products, child) {
                  return products.products.isEmpty
                      ? child as Widget
                      : SafeArea(
                          child: Column(
                            children: [
                              const SortFilter(),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ParagraphText(
                                  text: '(${products.products.length} items)',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Expanded(
                                child: GridView.builder(
                                  padding: const EdgeInsets.all(10.0),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 3,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                  ),
                                  itemBuilder: (context, index) => ProductItem(
                                    product: products.products[index],
                                    key: Key(products.products[index].id),
                                  ),
                                  itemCount: products.products.length,
                                ),
                              )
                            ],
                          ),
                        );
                },
                child: const Center(
                  child: Text('Got no Product yet, start adding some!'),
                ),
              ),
      ),
    );
  }
}
