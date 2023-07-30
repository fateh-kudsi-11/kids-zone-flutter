import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/auth.dart';
import '/layouts/heading_text.dart';
import '/Widgets/bag_product_list.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isAuth = Provider.of<Auth>(context).isAuth;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: HeadingText(
          text: 'Bag',
          size: 18,
          letterSpacing: 0.5,
        ),
      ),
      child: isAuth
          ? const SafeArea(
              child: BagProductList(),
            )
          : const Center(
              child: Text('Please Sign in'),
            ),
    );
  }
}
