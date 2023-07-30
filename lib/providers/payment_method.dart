import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/models/payment_method_model.dart';

class PaymentMethod with ChangeNotifier {
  List<PaymentMethodModel> _paymentMethods = [];

  List<PaymentMethodModel> get paymentMethods {
    return [..._paymentMethods];
  }

  Future<void> fetchPaymentMethod() async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/paymentMethod',
    );
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        List<PaymentMethodModel> paymentMetods = [];
        final res = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
        final extractedData = json.decode(res.body);
        final data = extractedData['paymentMethod'];

        data.forEach((value) {
          paymentMetods.add(
            PaymentMethodModel(
              id: value['_id'],
              cardNumber: value['cardNumber'],
              cardName: value['cardName'],
              month: value['month'],
              year: value['year'],
              createdAt: DateTime.parse(
                value['createdAt'],
              ),
            ),
          );
        });

        _paymentMethods = paymentMetods;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> createPaymentMethod(Map<String, String> paymentMethod) async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/paymentMethod',
    );
    final body = json.encode(paymentMethod);
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

  Future<void> deletePaymentMethod(String id) async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/paymentMethod/$id',
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

        _paymentMethods =
            _paymentMethods.where((element) => element.id != id).toList();

        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }
}
