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

class BagProductItem extends StatefulWidget {
  final ProductModel product;
  const BagProductItem({Key? key, required this.product}) : super(key: key);

  @override
  State<BagProductItem> createState() => _BagProductItemState();
}

class _BagProductItemState extends State<BagProductItem> {
  String _selectedColor = '';
  String _selectedSize = '';
  String _selectedQty = '1';

  final qtyList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

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

  void showPicker(String type) {
    showCupertinoModalPopup(
        barrierDismissible: false,
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
                  if (type == 'qty') {
                    updateQty();
                  }
                  Navigator.of(context).pop();
                },
              ),
              title: type == 'color'
                  ? const Text('Selecte Color')
                  : const Text('Selecte Size'),
            )));
  }

  Future<void> updateQty() async {
    setState(() {
      _loading = true;
    });
    String orderId = Provider.of<Bag>(context, listen: false)
        .bag
        .orderItems
        .firstWhere((element) => element.product == widget.product.id)
        .id;

    await Provider.of<Bag>(context, listen: false)
        .updateQty(orderId, int.parse(_selectedQty));
    setState(() {
      _loading = false;
    });
  }

  Future<void> deleteProductFromBag() async {
    String orderId = Provider.of<Bag>(context, listen: false)
        .bag
        .orderItems
        .firstWhere((element) => element.product == widget.product.id)
        .id;
    setState(() {
      _loading = true;
    });
    await Provider.of<Bag>(context, listen: false)
        .deleteProductFromBag(orderId);
    setState(() {
      _loading = false;
    });
  }

  Future<void> moveProductToWishList() async {
    String orderId = Provider.of<Bag>(context, listen: false)
        .bag
        .orderItems
        .firstWhere((element) => element.product == widget.product.id)
        .id;
    setState(() {
      _loading = true;
    });
    await Provider.of<Bag>(context, listen: false)
        .moveProductToWishList(orderId, widget.product.id);
    fetchWishList();
  }

  Future<void> fetchWishList() async {
    Future.wait([
      Provider.of<WishList>(context, listen: false).fetchWishList(),
      Provider.of<WishList>(context, listen: false).fetchWishListProducts()
    ]);
    setState(() {
      _loading = false;
    });
  }

  Widget buildSelecter(String type) {
    var items = [];

    switch (type) {
      case 'color':
        items = widget.product.availableColor;
        break;
      case 'size':
        items = widget.product.size;
        break;
      case 'qty':
        items = qtyList;
        break;
    }

    return CupertinoPicker(
        itemExtent: 64,
        onSelectedItemChanged: (index) {
          if (type == 'color') {
            setState(() {
              _selectedColor = widget.product.availableColor[index];
            });
          } else if (type == 'size') {
            setState(() {
              _selectedSize = widget.product.size[index];
            });
          } else {
            setState(() {
              _selectedQty = qtyList[index];
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
                deleteProductFromBag();
              },
              backgroundColor: const Color(0xFFEB4D3D),
              foregroundColor: CupertinoColors.white,
              icon: CupertinoIcons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) async {
              moveProductToWishList();
            },
            backgroundColor: const Color(0xFF3B864F),
            foregroundColor: CupertinoColors.white,
            icon: CupertinoIcons.heart,
            label: 'Save',
          ),
        ]),
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
                          constraints: const BoxConstraints(minWidth: 200),
                          child: Row(
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  showPicker('qty');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadingText(
                                      text: _selectedQty == ''
                                          ? 'Qty'
                                          : _selectedQty,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 25,
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
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
