class Category {
  final String title;
  final String image;
  Category({
    required this.title,
    required this.image,
  });
}

class CategorySelect {
  static final boysCategory = [
    Category(title: 'Activewear', image: 'assets/cb1.png'),
    Category(title: 'Jackets', image: 'assets/cb2.png'),
    Category(title: 'Outfits', image: 'assets/cb3.png'),
    Category(title: 'Suits', image: 'assets/cb4.png'),
    Category(title: 'Shoes', image: 'assets/cb5.png'),
  ];
  static final girlsCategory = [
    Category(title: 'Activewear', image: 'assets/gb1.png'),
    Category(title: 'Jackets', image: 'assets/gb2.png'),
    Category(title: 'Dresses', image: 'assets/gb3.png'),
    Category(title: 'Skirts', image: 'assets/gb4.png'),
    Category(title: 'Shoes', image: 'assets/cb5.png'),
  ];
}
