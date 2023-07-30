import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/providers/wish_list.dart';
import '/providers/bag.dart';
import '/layouts/heading_text.dart';
import '/layouts/paragraph_text.dart';
import '/models/product_model.dart';

class WishProductItem extends StatefulWidget {
  final ProductModel product;
  const WishProductItem({Key? key, required this.product}) : super(key: key);

  @override
  State<WishProductItem> createState() => _WishProductItemState();
}

class _WishProductItemState extends State<WishProductItem> {
  String _selectedColor = '';
  String _selectedSize = '';
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

  Future<void> moveProductToBag() async {
    if (_selectedColor == '' && _selectedSize == '') {
      return showSuccessMessage(
          'Color and Size are required', 'Please Selecet Color And Size');
    }
    if (_selectedColor == '') {
      return showSuccessMessage('Color is required', 'Please Selecet Color');
    }
    if (_selectedSize == '') {
      return showSuccessMessage('Size is required', 'Please Selecet Size');
    }
    try {
      setState(() {
        _loading = true;
      });
      await Provider.of<WishList>(context, listen: false)
          .moveProductToBag(_selectedColor, _selectedSize, widget.product.id);
      fetchBag();
      showSuccessMessage('success', 'Product has been moved to your bag');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchBag() async {
    await Provider.of<Bag>(context, listen: false).fetchBag();
  }

  void showPicker(String type) {
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

  Widget buildSelecter(String type) {
    final items =
        type == 'color' ? widget.product.availableColor : widget.product.size;

    return CupertinoPicker(
        itemExtent: 64,
        onSelectedItemChanged: (index) {
          if (type == 'color') {
            setState(() {
              _selectedColor = widget.product.availableColor[index];
            });
          } else {
            setState(() {
              _selectedSize = widget.product.size[index];
            });
          }
        },
        children: items
            .map((e) => Center(
                  child: Text(e),
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xffd9d9d9)))),
      child: Slidable(
        key: Key(widget.product.id),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                setState(() {
                  _loading = true;
                });
                await Provider.of<WishList>(context, listen: false)
                    .deleteProductFromWishList(widget.product.id);
              },
              backgroundColor: const Color(0xFFEB4D3D),
              foregroundColor: CupertinoColors.white,
              icon: CupertinoIcons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: _loading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Row(
                children: [
                  SizedBox(
                    width: 140,
                    height: 160,
                    child: Image.network(
                      'https://kids-zone-backend-v2.onrender.com${widget.product.images[0].images[0]}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ParagraphText(
                          text: '\$ ${widget.product.price / 1000}',
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ParagraphText(
                          text: widget.product.productName,
                          size: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        Container(
                          constraints: const BoxConstraints(minWidth: 200),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() {
                                    _selectedColor =
                                        widget.product.availableColor[0];
                                  });

                                  showPicker('color');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadingText(
                                      text: _selectedColor == ''
                                          ? 'Color'
                                          : _selectedColor,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      CupertinoIcons.chevron_down,
                                      size: 18,
                                      color: themeDark
                                          ? const Color(0xffeeeeee)
                                          : const Color(0xff1f1f1f),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 20,
                                color: themeDark
                                    ? const Color(0xff4d4d4d)
                                    : const Color(0xffd9d9d9),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() {
                                    _selectedSize = widget.product.size[0];
                                  });
                                  showPicker('size');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadingText(
                                      text: _selectedSize == ''
                                          ? 'Size'
                                          : _selectedSize,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      CupertinoIcons.chevron_down,
                                      size: 18,
                                      color: themeDark
                                          ? const Color(0xffeeeeee)
                                          : const Color(0xff1f1f1f),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 115,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: themeDark
                                      ? const Color(0xffeeeeee)
                                      : const Color(0xff1f1f1f))),
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: moveProductToBag,
                            child: const HeadingText(text: 'MOVE TO BAG'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
