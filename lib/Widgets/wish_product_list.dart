import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/wish_list.dart';
import '/Widgets/wish_product_item.dart';
import '/Widgets/wish_product_header.dart';
import '/layouts/paragraph_text.dart';

class WishProductList extends StatelessWidget {
  const WishProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Provider.of<WishList>(context, listen: false).fetchWishListProducts(),
        Provider.of<WishList>(context, listen: false).fetchWishList()
      ]),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Consumer<WishList>(
              builder: (context, wishList, child) {
                return wishList.wishListProducts.isEmpty
                    ? child as Widget
                    : Column(
                        children: [
                          const WishProductHeader(),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) => WishProductItem(
                                product: wishList.wishListProducts[index],
                                key: Key(wishList.wishListProducts[index].id),
                              ),
                              itemCount: wishList.wishListProducts.length,
                            ),
                          ),
                        ],
                      );
              },
              child: const Center(
                child: ParagraphText(
                    text: 'Got no Saved Item  yet, start adding some!'),
              ),
            ),
    );
  }
}
