class CartItem {
  final String productCode;
  int quantity;

  CartItem({
    required this.productCode,
    this.quantity = 1,
  });
}