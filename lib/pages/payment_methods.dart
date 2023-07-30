import 'package:flutter/cupertino.dart';
import 'package:kidszone/Widgets/payment_method_list.dart';
import '/layouts/secondary_button.dart';
import '/layouts/heading_text.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const HeadingText(
          text: 'Payment Methods',
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
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              child: SecondaryButton(
                margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                padding: EdgeInsets.zero,
                title: 'ADD NEW PAYMENT METHOD',
                onPressed: () {
                  Navigator.of(context).pushNamed('/newPaymentMethod');
                },
              ),
            ),
            const PaymentMethodList()
          ],
        ),
      ),
    );
  }
}
