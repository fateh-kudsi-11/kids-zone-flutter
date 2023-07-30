import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/models/bag_model.dart';
import '/models/product_model.dart';

class Bag with ChangeNotifier {
  late BagModel _bag;

  BagModel get bag => _bag;

  List<ProductModel> _bagProducts = [];

  List<ProductModel> get bagProducts {
    return [..._bagProducts];
  }

  Future<void> addProductToBag(
      String selectedColor, String selectedSize, String productId) async {
    final bagUrl = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/bag/',
    );

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        final body = {
          'selectedColor': selectedColor,
          'selectedSize': selectedSize,
          'products': productId
        };

        await http.post(bagUrl,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: json.encode(body));

        await fetchBag();

        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> fetchBag() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/bag/',
    );
    if (token != null) {
      try {
        final res = await http.get(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );
        final extractedData = json.decode(res.body);

        final bagData = extractedData['bag'];
        final data = extractedData['products'];

        if (bagData == null) return;

        final List<OrderItem> loadedOrderItems = [];

        bagData['OrderItem'].forEach((orderItem) {
          loadedOrderItems.add(OrderItem(
            product: orderItem['products'],
            id: orderItem['_id'],
            quantity: orderItem['quantity'],
            selectedSize: orderItem['selectedSize'],
            selectedColor: orderItem['selectedColor'],
            createdAt: DateTime.parse(
              orderItem['createdAt'],
            ),
          ));
        });

        _bag = BagModel(
          orderItems: loadedOrderItems,
          createdAt: DateTime.parse(
            bagData['createdAt'],
          ),
        );

        final List<ProductModel> loadedProduct = [];
        data.forEach((product) {
          List<ColorModel> avColores = [];
          List<ImageModel> avImages = [];

          product['images'].forEach((y) {
            avImages.add(
              ImageModel(
                imagesColor: y['imagesColor'],
                images: List<String>.from(y['images'] as List),
              ),
            );
          });
          product['colors'].forEach(
            (x) {
              avColores.add(
                ColorModel(
                  colorName: x['colorName'],
                  colorCode: x['colorCode'],
                ),
              );
            },
          );
          loadedProduct.add(
            ProductModel(
              id: product['_id'],
              gender: product['gender'],
              productName: product['productName'],
              colors: avColores,
              images: avImages,
              price: product['price'],
              brand: product['brand'],
              description: product['description'],
              size: List<String>.from(product['size'] as List),
              details: List<String>.from(product['details'] as List),
              availableColor:
                  List<String>.from(product['availableColor'] as List),
              category: product['category'],
              productType: product['productType'],
              productNumber: product['productNumber'],
              watchCount: product['watchCount'],
              createAt: DateTime.parse(
                product['createAt'],
              ),
            ),
          );
        });

        _bagProducts = loadedProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  double getTotalSum() {
    List<double> totalSum = [];
    final products = bagProducts;
    final orderItems = bag.orderItems;
    for (var product in products) {
      final order =
          orderItems.firstWhere((element) => element.product == product.id);
      totalSum.add((product.price * order.quantity).toDouble());
    }
    final double total = totalSum.reduce((a, b) => a + b);
    return total / 1000;
  }

  Future<void> updateQty(String orderItemId, int qty) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/bag/orderItem/$orderItemId',
    );

    try {
      final body = json.encode({'quantity': qty});
      await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: body,
      );

      await fetchBag();

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteProductFromBag(String orderItemId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/bag/$orderItemId',
    );
    if (token != null) {
      try {
        await http.delete(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );
        await fetchBag();
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> moveProductToWishList(
      String orderItemId, String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/bag/wishList',
    );
    if (token != null) {
      try {
        final body = {'productId': productId, 'orderItemId': orderItemId};
        await http.post(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: json.encode(body),
        );
        await fetchBag();
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }
}
