class PaymentMethodModel {
  final String id;
  final String cardNumber;
  final String cardName;
  final String month;
  final String year;

  final DateTime createdAt;

  PaymentMethodModel({
    required this.id,
    required this.cardNumber,
    required this.cardName,
    required this.month,
    required this.year,
    required this.createdAt,
  });
}
