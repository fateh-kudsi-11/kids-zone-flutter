import 'package:flutter/cupertino.dart';
import 'package:kidszone/Widgets/address_book_item.dart';
import 'package:kidszone/layouts/paragraph_text.dart';
import 'package:provider/provider.dart';
import '/providers/address_book.dart';

class AddressBookList extends StatelessWidget {
  const AddressBookList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<AddressBook>(context, listen: false).fetchAddressBooks(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Consumer<AddressBook>(
                  builder: (context, addressBook, child) {
                    return addressBook.addressBooks.isEmpty
                        ? child as Widget
                        : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) => AddressBookItem(
                                addressBook: addressBook.addressBooks[index],
                              ),
                              itemCount: addressBook.addressBooks.length,
                            ),
                          );
                  },
                  child: const Center(
                    child: ParagraphText(
                        text: 'Got no address book yet, start adding some!'),
                  ),
                ),
    );
  }
}
