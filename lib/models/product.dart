class Product {
  final int categoryId;
  final String name;
  final String priceText;
  final double price;
  final String currency;
  final String image;
  final double rating;
  final String orderCount;
  final String barcode;
  final String? categoryName;
  final double commission;

  const Product({required this.categoryId, required this.name, required this.priceText, required this.price, required this.currency, required this.image, required this.rating, required this.orderCount, required this.barcode, this.categoryName, this.commission = 0});

  double get commissionAmount => price * commission / 100;
  double netAmount({double shipment = 0}) => price - commissionAmount - shipment;

  factory Product.fromJson(Map<String, dynamic> json, String barcode) {
    final price = (json['price'] as Map?)?.cast<String, dynamic>() ?? {};
    final rating = (json['ratingScore'] as Map?)?.cast<String, dynamic>() ?? {};
    final proofs = (json['socialProof'] as List? ?? const []);
    String order = '-';
    for (final item in proofs) {
      if (item is Map && item['key'] == 'orderCount') order = '${item['value'] ?? '-'}';
    }
    final current = (price['discountedPrice'] as num?)?.toDouble() ?? (price['current'] as num?)?.toDouble() ?? 0;
    return Product(
      categoryId: (json['category']?['id'] as num?)?.toInt() ?? (json['categoryId'] as num?)?.toInt() ?? 0,
      name: '${json['name'] ?? 'İsimsiz ürün'}',
      priceText: '${price['discountedPriceText'] ?? price['currentText'] ?? current.toStringAsFixed(2)}',
      price: current,
      currency: '${price['currencySymbol'] ?? 'TL'}',
      image: '${json['image'] ?? ''}',
      rating: (rating['averageRating'] as num?)?.toDouble() ?? 0,
      orderCount: order,
      barcode: barcode,
    );
  }
}
