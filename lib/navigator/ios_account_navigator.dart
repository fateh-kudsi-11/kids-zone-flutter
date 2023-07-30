import 'package:flutter/cupertino.dart';
import '/pages/add_new_payment_method.dart';
import '/pages/my_account_page.dart';
import '/pages/my_details.dart';
import '/pages/my_orders.dart';
import '/pages/change_password.dart';
import '/pages/address_book.dart';
import '/pages/add_new_address_book.dart';
import '/pages/payment_methods.dart';
import '/pages/notification.dart';

class IOSAccountNavigator extends StatelessWidget {
  const IOSAccountNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) => const MyAccountPage(),
      routes: {
        '/myDetails': (context) => const MyDetails(),
        '/myOrders': (context) => const MyOrders(),
        '/changePassword': (context) => const ChangePassword(),
        '/addressBook': (context) => const AddressBook(),
        '/newAddressBook': (context) => const AddNewAddressBook(),
        '/newPaymentMethod': (context) => const AddNewPaymentMethod(),
        '/paymentMethods': (context) => const PaymentMethods(),
        '/notification': (context) => const NotificationPage(),
      },
    );
  }
}
