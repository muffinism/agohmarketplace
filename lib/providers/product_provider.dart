import '../models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    Product(id: 'p1', title: 'Laptop', price: 999.99),
    Product(id: 'p2', title: 'Smartphone', price: 499.99),
    Product(id: 'p3', title: 'Tablet', price: 299.99),
    Product(id: 'p4', title: 'Smartwatch', price: 199.99),
  ];

  List<Product> get items {
    return [..._items];
  }
}
