class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem ({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      title: map['title'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

}