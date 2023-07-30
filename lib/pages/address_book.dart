import 'package:flutter/cupertino.dart';
import '/Widgets/address_book_list.dart';
import '/layouts/secondary_button.dart';
import '/layouts/heading_text.dart';

class AddressBook extends StatelessWidget {
  const AddressBook({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const HeadingText(
          text: 'Address Book',
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
              title: 'ADD NEW ADDRESS BOOK',
              onPressed: () {
                Navigator.of(context).pushNamed('/newAddressBook');
              },
            ),
          ),
          const AddressBookList()
        ],
      )),
    );
  }
}
