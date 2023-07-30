import 'package:flutter/cupertino.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/layouts/slider_heading.dart';
import '/providers/auth.dart';
import '/providers/wish_list.dart';
import '/providers/stage.dart';
import '/providers/bag.dart';

class ProductActionButtons extends StatefulWidget {
  final String productId;
  final String selectedColor;
  final String selectedSize;

  const ProductActionButtons({
    Key? key,
    required this.productId,
    required this.selectedColor,
    required this.selectedSize,
  }) : super(key: key);

  @override
  State<ProductActionButtons> createState() => _ProductActionButtonsState();
}

class _ProductActionButtonsState extends State<ProductActionButtons> {
  bool _loading = false;
  Future<void> showSuccessMessage(String title, String message) async {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    Flushbar(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      title: title,
      message: message,
      titleColor: themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
      backgroundColor:
          themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
      messageColor:
          themeDark ? const Color(0xff1f1f1f) : const Color(0xffeeeeee),
      duration: const Duration(seconds: 5),
    ).show(context);
  }

  Future<void> onFavClick(bool isFav) async {
    final isAuth = Provider.of<Auth>(context, listen: false).isAuth;

    if (!isAuth) {
      showDialog('save list');
      return;
    }

    setState(() {
      _loading = true;
    });
    if (isFav) {
      await Provider.of<WishList>(context, listen: false)
          .deleteProductFromWishList(widget.productId);
      showSuccessMessage(
        'Success',
        'Product has been delete it from your saved item list',
      );
    } else {
      await Provider.of<WishList>(context, listen: false)
          .addProductToWishList(widget.productId);
      showSuccessMessage(
        'Success',
        'Product has been add it to your saved item list',
      );
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> onAddToProduct() async {
    final isAuth = Provider.of<Auth>(context, listen: false).isAuth;

    if (!isAuth) {
      showDialog('bag');
      return;
    }

    if (widget.selectedColor == '' && widget.selectedSize == '') {
      showSuccessMessage(
        'Color and Size are requird',
        'Please Select color and size',
      );
      return;
    }
    if (widget.selectedColor == '') {
      showSuccessMessage(
        'Color is requird',
        'Please Select color',
      );
      return;
    }

    if (widget.selectedSize == '') {
      showSuccessMessage(
        ' Size is requird',
        'Please Select  size',
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    await Provider.of<Bag>(context, listen: false).addProductToBag(
        widget.selectedColor, widget.selectedSize, widget.productId);

    showSuccessMessage(
      'Success',
      'Product has been add it to your bag',
    );

    setState(() {
      _loading = false;
    });
  }

  Future<void> showDialog(
    String type,
  ) async {
    await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Sign in Required'),
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
              'To add this product to your $type please sign in first , do you want to sign in ?'),
        ),
        actions: [
          CupertinoButton(
            child: const Text(
              'Yes',
              style: TextStyle(color: CupertinoColors.systemRed),
            ),
            onPressed: () {
              Provider.of<StageManger>(context, listen: false).setStage('auth');
              Navigator.pop(context);
            },
          ),
          CupertinoButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    final isAuth = Provider.of<Auth>(context, listen: false).isAuth;
    List<String>? productsId;
    bool isFav = false;
    if (isAuth) {
      productsId = Provider.of<WishList>(context).wishList?.products;
      if (productsId != null) {
        isFav = productsId.contains(widget.productId);
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 264,
            height: 46,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onAddToProduct,
              color:
                  themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
              borderRadius: const BorderRadius.all(Radius.zero),
              child: _loading
                  ? CupertinoActivityIndicator(
                      color: themeDark
                          ? const Color(0xff1f1f1f)
                          : const Color(0xffeeeeee),
                    )
                  : const SliderHeading(
                      text: 'ADD TO BAG',
                      size: 24,
                    ),
            ),
          ),
          Container(
            width: 46,
            height: 46,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _loading
                  ? null
                  : () {
                      onFavClick(isFav);
                    },
              color: const Color(0xffd9d9d9),
              borderRadius: const BorderRadius.all(Radius.zero),
              child: _loading
                  ? const CupertinoActivityIndicator()
                  : Icon(
                      isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                      color: const Color(0xff1f1f1f),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
