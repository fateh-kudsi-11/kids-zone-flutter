class AddressBookModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String city;
  final String postCode;
  final DateTime createdAt;

  AddressBookModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.city,
    required this.postCode,
    required this.createdAt,
  });
}
