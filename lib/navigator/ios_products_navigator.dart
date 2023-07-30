import 'package:flutter/cupertino.dart';
import '/pages/filter_page.dart';
import '/pages/search_page.dart';
import '/pages/products_page.dart';
import '/pages/product.dart';

class IOSProductsNavigator extends StatelessWidget {
  const IOSProductsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) => const SearchPage(),
      routes: {
        '/products': (context) => const ProductsPage(),
        '/filter': (context) => const FilterPage(),
        '/product': (context) => const Product()
      },
    );
  }
}
