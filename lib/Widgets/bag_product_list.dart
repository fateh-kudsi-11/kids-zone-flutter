import 'package:flutter/cupertino.dart';
import 'package:kidszone/Widgets/bag_product_Header.dart';
import 'package:kidszone/Widgets/bag_product_item.dart';
import 'package:provider/provider.dart';
import '/providers/bag.dart';
import '/layouts/paragraph_text.dart';

class BagProductList extends StatelessWidget {
  const BagProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Bag>(context, listen: false).fetchBag(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Consumer<Bag>(
              builder: (context, bag, child) {
                return bag.bagProducts.isEmpty
                    ? child as Widget
                    : Column(
                        children: [
                          const BagProductHeader(),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) => BagProductItem(
                                product: bag.bagProducts[index],
                                key: Key(bag.bagProducts[index].id),
                              ),
                              itemCount: bag.bagProducts.length,
                            ),
                          ),
                        ],
                      );
              },
              child: const Center(
                child: ParagraphText(text: 'no products in your bag  yet'),
              ),
            ),
    );
  }
}
