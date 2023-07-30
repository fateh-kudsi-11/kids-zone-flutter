import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/layouts/paragraph_text.dart';
import '/models/product_model.dart';
import '/providers/theme.dart';
import '/providers/products.dart';
import '/providers/wish_list.dart';
import '/providers/auth.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  void redirctToProduct(BuildContext context) {
    Provider.of<Products>(context, listen: false).setProduct(product);
    Navigator.of(context).pushNamed('/product');
  }

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    final isAuth = Provider.of<Auth>(context).isAuth;
    var isFav = false;
    if (isAuth) {
      final favProducts = Provider.of<WishList>(context).wishList?.products;
      if (favProducts != null) {
        isFav = favProducts.contains(product.id);
      }
    }

    return GestureDetector(
      onTap: () {
        redirctToProduct(context);
      },
      child: Container(
        width: 170,
        height: 247,
        color: themeDark ? const Color(0xff2d2d2d) : const Color(0xffffffff),
        child: Column(
          children: [
            Hero(
              tag: product.id,
              child: Image.network(
                  'https://kids-zone-backend-v2.onrender.com${product.images[0].images[0]}'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ParagraphText(
                    text: '\$${product.price / 1000}',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  Icon(
                    isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    color: const Color(0xff757575),
                    size: 24,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ParagraphText(
                text: product.productName,
                size: 14,
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}
