import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/providers/payment_method.dart';
import '/Widgets/payment_method_item.dart';
import '/layouts/paragraph_text.dart';

class PaymentMethodList extends StatelessWidget {
  const PaymentMethodList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<PaymentMethod>(context, listen: false)
          .fetchPaymentMethod(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Consumer<PaymentMethod>(
              builder: (context, paymentMethods, child) {
                return paymentMethods.paymentMethods.isEmpty
                    ? child as Widget
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => PaymentMethodItem(
                            paymentMethod: paymentMethods.paymentMethods[index],
                          ),
                          itemCount: paymentMethods.paymentMethods.length,
                        ),
                      );
              },
              child: const Center(
                child: ParagraphText(
                    text: 'Got no payment Method yet, start adding some!'),
              ),
            ),
    );
  }
}
