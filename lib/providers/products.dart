import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '/models/filter_element.dart';
import '/models/product_model.dart';

class Products extends ChangeNotifier {
  List<ProductModel> _products = [];

  ProductModel? _product;
  final Map<String, List<FilterElement>> _filterElements = {};
  final Map<String, int> _priceRang = {};
  bool _loading = false;
  final String? _gender;
  final String? _directory;
  final String? _sort;
  final Map<String, String>? _filterOutput;

  Products(this._gender, this._directory, this._sort, this._filterOutput);

  List<ProductModel> get products {
    return [..._products];
  }

  bool get loading => _loading;
  ProductModel? get product => _product;

  Future<void> fetchProducts() async {
    final filter = {'gender': _gender};
    if (_directory != "") {
      filter['category'] = _directory;
    }

    if (_sort != "") {
      filter['sort'] = _sort;
    }

    if (_filterOutput != null) {
      if (_filterOutput?['brand'] != '') {
        filter['brand'] = _filterOutput?['brand'];
      }
      if (_filterOutput?['color'] != '') {
        filter['color'] = _filterOutput?['color'];
      }
      if (_filterOutput?['size'] != '') {
        filter['size'] = _filterOutput?['size'];
      }
      if (_filterOutput?['priceRange'] != '') {
        filter['priceRange'] = _filterOutput?['priceRange'];
      }
    }

    final url = Uri.https(
        'kids-zone-backend-v2.onrender.com', '/api/v1/products', filter);

    _loading = true;
    try {
      final res = await http.get(url);
      final extractedData = json.decode(res.body);
      final filterEl = extractedData['filterElements'];

      final List<FilterElement> brands = [];
      final List<FilterElement> colors = [];
      final List<FilterElement> sizes = [];

      filterEl['brands'].forEach((b) {
        brands.add(FilterElement(b['title'], b['count']));
      });
      filterEl['colors'].forEach((b) {
        colors.add(FilterElement(b['title'], b['count']));
      });
      filterEl['sizes'].forEach((b) {
        sizes.add(FilterElement(b['title'], b['count']));
      });

      _filterElements['brands'] = brands;
      _filterElements['colors'] = colors;
      _filterElements['sizes'] = sizes;
      _priceRang['maxPrice'] = filterEl['price']['maxPrice'];
      _priceRang['minPrice'] = filterEl['price']['minPrice'];

      final data = extractedData['data'];
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

      _products = loadedProduct;
      _loading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List<FilterElement>? fetchFilterElement(String kind) {
    return _filterElements[kind];
  }

  Map<String, int> fetchPriceRangeValues() {
    return _priceRang;
  }

  void setProduct(ProductModel product) {
    _product = product;
    notifyListeners();
  }
}
