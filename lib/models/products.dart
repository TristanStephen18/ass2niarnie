class Products{
  String code;
  String productname;
  double price;
  bool isFav;

  Products({
    required this.code,
    required this.productname,
    required this.price,
    this.isFav = false,
  });
}