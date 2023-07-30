import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/auth.dart';
import '/Widgets/wish_product_list.dart';
import '/layouts/heading_text.dart';

class SavedItemPage extends StatelessWidget {
  const SavedItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isAuth = Provider.of<Auth>(context).isAuth;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: HeadingText(
          text: 'Saved Items',
          size: 18,
          letterSpacing: 0.5,
        ),
      ),
      child: isAuth
          ? const SafeArea(
              child: WishProductList(),
            )
          : const Center(
              child: Text('Please Sign in'),
            ),
    );
  }
}
