import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/models/wish_list_model.dart';
import '/models/product_model.dart';

class WishList with ChangeNotifier {
  WishListModel? _wishList;

  WishListModel? get wishList => _wishList;

  List<ProductModel> _wishListProducts = [];

  List<ProductModel> get wishListProducts {
    return [..._wishListProducts];
  }

  Future<void> fetchWishList() async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/wishList',
    );
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        final res = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
        final extractedData = json.decode(res.body);
        final data = extractedData['wishList'];

        if (data != null) {
          _wishList = WishListModel(
            products: List<String>.from(data['products'] as List),
            createdAt: DateTime.parse(
              data['createdAt'],
            ),
          );
          notifyListeners();
        }
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> addProductToWishList(String productId) async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/wishList/$productId',
    );
    final url2 = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/wishList',
    );
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        final res = await http.get(
          url2,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );
        final extractedData = json.decode(res.body);
        final data = extractedData['wishList'];
        if (data == null) {
          await http.post(
            url2,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
          );
        }
        final res2 = await http.post(
          url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        );
        final extractedData2 = json.decode(res2.body);
        final data2 = extractedData2['wishList'];

        _wishList = WishListModel(
          products: List<String>.from(data2['products'] as List),
          createdAt: DateTime.parse(
            data2['createdAt'],
          ),
        );

        await fetchWishListProducts();

        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> deleteProductFromWishList(String productId) async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/wishList/$productId',
    );

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        final res = await http.delete(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        final extractedData = json.decode(res.body);
        final data = extractedData['wishList'];

        _wishList = WishListModel(
          products: List<String>.from(data['products'] as List),
          createdAt: DateTime.parse(
            data['createdAt'],
          ),
        );

        await fetchWishListProducts();

        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> fetchWishListProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/products/wishList',
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
        final data = extractedData['products'];
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
        _wishListProducts = loadedProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> moveProductToBag(
      String selectedColor, String selectedSize, String productId) async {
    final url = Uri.https(
      'kids-zone-backend-v2.onrender.com',
      '/api/v1/wishList/$productId',
    );

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
        final res = await http.delete(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        final extractedData = json.decode(res.body);
        final data = extractedData['wishList'];

        _wishList = WishListModel(
          products: List<String>.from(data['products'] as List),
          createdAt: DateTime.parse(
            data['createdAt'],
          ),
        );

        await fetchWishListProducts();

        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }
}
