import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/models/address_book_model.dart';

class AddressBook with ChangeNotifier {
  List<AddressBookModel> _addressBooks = [];

  List<AddressBookModel> get addressBooks {
    return [..._addressBooks];
  }

  Future<void> fetchAddressBooks() async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/addressbook',
    );
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        List<AddressBookModel> addressBooks = [];
        final res = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
        final extractedData = json.decode(res.body);
        final data = extractedData['addressBook'];

        data.forEach((value) {
          addressBooks.add(
            AddressBookModel(
              id: value['_id'],
              firstName: value['firstName'],
              lastName: value['lastName'],
              phone: value['phone'],
              address: value['address'],
              city: value['city'],
              postCode: value['postCode'],
              createdAt: DateTime.parse(
                value['createdAt'],
              ),
            ),
          );
        });

        _addressBooks = addressBooks;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> createAddressBooks(Map<String, String> addressBook) async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/addressbook',
    );
    final body = json.encode(addressBook);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        await http.post(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: body,
        );
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> deleteAddressBooks(String id) async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/addressbook/$id',
    );

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        await http.delete(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        _addressBooks =
            _addressBooks.where((element) => element.id != id).toList();

        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }
}
