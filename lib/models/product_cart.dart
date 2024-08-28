class ProductCart {
  int? productId;
  String? title;
  double? price;
  String? category;
  String? image;
  int? quantity;

  ProductCart({
    this.productId,
    this.title,
    this.quantity,
    this.price,
    this.image,
    this.category,
  });

  ProductCart.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    title = json['title'];
    price = json['price'];
    category = json['category'];
    image = json['image'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['title'] = title;
    data['price'] = price;
    data['category'] = category;
    data['image'] = image;
    data['quantity'] = quantity;
    return data;
  }
}
