class Product {
  final int productId;
  final String productName;
  final int productQuantity;
  final double price;

  Product({
    required this.productId,
    required this.productName,
    required this.productQuantity,
    required this.price,
  });

  // Factory untuk parsing dari JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      productQuantity: json['product_quantity'],
      price: json['price'].toDouble(),
    );
  }

  // Untuk encode ke JSON
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_quantity': productQuantity,
      'price': price,
    };
  }
}
