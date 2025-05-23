import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("My Cart")),
      body: Column(
        children: [
          Text("Total Price: \$${cartProvider.totalPrice}"),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (ctx, i) {
                final item = cartProvider.items.values.toList()[i];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text("\$${item.price} x ${item.quantity}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
