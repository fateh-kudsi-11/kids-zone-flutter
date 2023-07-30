import 'package:flutter/cupertino.dart';
import '/layouts/heading_text.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const HeadingText(
          text: 'My Orders',
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
      child: const Center(child: Text('My Orders')),
    );
  }
}
