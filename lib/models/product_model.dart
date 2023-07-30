class ColorModel {
  final String colorName;
  final String colorCode;

  ColorModel({
    required this.colorName,
    required this.colorCode,
  });
}

class ImageModel {
  final String imagesColor;
  final List<String> images;

  ImageModel({
    required this.imagesColor,
    required this.images,
  });
}

class ProductModel {
  final String id;
  final String gender;
  final String productName;
  final String brand;
  final int price;
  final List<String> size;
  final List<String> availableColor;
  final List<ColorModel> colors;
  final List<ImageModel> images;
  final String description;
  final List<String> details;
  final String category;
  final String productType;
  final int productNumber;
  final DateTime createAt;
  final int watchCount;

  ProductModel({
    required this.id,
    required this.gender,
    required this.productName,
    required this.brand,
    required this.price,
    required this.size,
    required this.availableColor,
    required this.colors,
    required this.images,
    required this.description,
    required this.details,
    required this.category,
    required this.productType,
    required this.productNumber,
    required this.createAt,
    required this.watchCount,
  });
}
