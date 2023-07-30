import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/products.dart';
import '/providers/theme.dart';
import '/layouts/heading_text.dart';
import '/layouts/paragraph_text.dart';
import '/layouts/expandable_section.dart';
import '/widgets/product_carousel.dart';
import '/widgets/color_size_buttons.dart';
import '/widgets/product_action_buttons.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  String selectedColor = '';
  String selectedSize = '';

  void setColor(String newValue) {
    setState(() {
      selectedColor = newValue;
    });
  }

  void setSize(String newValue) {
    setState(() {
      selectedSize = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context).product;

    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    final details = product?.details
        .map(
          (e) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child: ParagraphText(
              text: '* $e',
              textAlign: TextAlign.left,
              size: 14,
            ),
          ),
        )
        .toList();
    if (product == null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushReplacementNamed('/');
      });
      return const CupertinoActivityIndicator();
    }
    return CupertinoPageScaffold(
      backgroundColor:
          themeDark ? const Color(0xff1d1d1d) : const Color(0xffeeeeee),
      navigationBar: CupertinoNavigationBar(
        middle: HeadingText(
          text: product.brand,
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
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 20,
                color: const Color(0xffffffff),
              ),
              Hero(
                tag: product.id,
                child: ProductCarousel(
                  imageList: selectedColor == ''
                      ? product.images[0].images
                      : product.images
                          .firstWhere(
                              (element) => element.imagesColor == selectedColor)
                          .images,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ParagraphText(
                        text: '\$${product.price / 1000}',
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ParagraphText(
                        text: product.productName,
                        fontWeight: FontWeight.w300,
                      )
                    ]),
              ),
              ColorSizeButtons(
                selectedColor: selectedColor,
                selectedSize: selectedSize,
                setColor: setColor,
                setSize: setSize,
                colorList: product.availableColor,
                sizeList: product.size,
              ),
              ProductActionButtons(
                productId: product.id,
                selectedColor: selectedColor,
                selectedSize: selectedSize,
              ),
              ExpandableSection(
                mainMargin: const EdgeInsets.only(top: 30),
                mainPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: 'Product Details',
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      ...?details,
                    ],
                  ),
                ),
              ),
              ExpandableSection(
                mainMargin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                mainPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: 'Product Description',
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ParagraphText(
                    text: product.description,
                    size: 14,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
