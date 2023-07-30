import 'package:flutter/cupertino.dart';
import 'package:kidszone/layouts/paragraph_text.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/providers/address_book.dart';
import '/models/address_book_model.dart';

class AddressBookItem extends StatelessWidget {
  final AddressBookModel addressBook;
  const AddressBookItem({Key? key, required this.addressBook})
      : super(key: key);

  Future<void> _deleteAddressBook(
    BuildContext context,
  ) async {
    try {
      await Provider.of<AddressBook>(context, listen: false)
          .deleteAddressBooks(addressBook.id);
    } catch (error) {
      await showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Failed'),
          content: const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('Some thing went wrong please try agin later'),
          ),
          actions: [
            CupertinoButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }

  Future<void> _showDialog(BuildContext context) async {
    await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete Address Book'),
        content: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text('Are You Sure You Want To Delete This Addres Book ?'),
        ),
        actions: [
          CupertinoButton(
            child: const Text(
              'Yes',
              style: TextStyle(color: CupertinoColors.destructiveRed),
            ),
            onPressed: () {
              _deleteAddressBook(context);
              Navigator.pop(context);
            },
          ),
          CupertinoButton(
            child: const Text(
              'No',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        width: double.infinity,
        height: 120,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xffd9d9d9),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ParagraphText(
                  text: '${addressBook.firstName} ${addressBook.lastName}',
                  size: 14,
                  textAlign: TextAlign.left,
                ),
                ParagraphText(
                  text: addressBook.address,
                  size: 14,
                  textAlign: TextAlign.left,
                ),
                ParagraphText(
                  text: addressBook.postCode,
                  size: 14,
                  textAlign: TextAlign.left,
                ),
                ParagraphText(
                  text: addressBook.phone,
                  size: 14,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            CupertinoButton(
              child: Icon(
                CupertinoIcons.xmark,
                color: themeDark
                    ? const Color(0xffeeeeee)
                    : const Color(0xff1f1f1f),
              ),
              onPressed: () async {
                await _showDialog(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
